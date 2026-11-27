import 'dart:async';
import 'dart:ui' show Size;

import 'package:flutter/foundation.dart';
import 'package:fvp/mdk.dart' as fvp;
import 'package:vision/widgets/media/player.dart';

/// A shared playback surface with delayed release while paused.
class RtspPlayer extends Player {
  /// [timeout] controls how long native resources are kept after the last
  /// active view pauses. [createPlayer] lets tests supply a fake native player.
  RtspPlayer(
    this._url, {
    this.timeout = const Duration(seconds: 30),
    fvp.Player Function()? createPlayer,
  }) : _createPlayer = createPlayer ?? fvp.Player.new;

  /// Grace period before releasing a paused native player.
  final Duration timeout;
  // A player can be shared by several widgets. Keep each lease's preference
  // separately so one widget cannot shorten another widget's grace period.
  final Map<Object, Duration> _leaseTimeouts = {};

  /// Updates one widget's timeout preference. If the player is already waiting
  /// to release resources, restart the countdown using the longest timeout
  /// requested by the remaining leases.
  void setLeaseTimeout(Object lease, Duration timeout) {
    if (_leaseTimeouts[lease] == timeout) return;
    _leaseTimeouts[lease] = timeout;
    if (_releaseTimer?.isActive ?? false) _scheduleRelease();
  }

  /// Removes a widget's timeout preference when its lease is detached. The
  /// remaining widgets continue to determine the shared player's timeout.
  void removeLeaseTimeout(Object lease) {
    _leaseTimeouts.remove(lease);
    if (_releaseTimer?.isActive ?? false) _scheduleRelease();
  }

  /// Chooses the longest lease timeout, or the constructor default if no
  /// widget has registered its preference.
  Duration get _releaseTimeout => _leaseTimeouts.values.fold<Duration>(
    _leaseTimeouts.isEmpty ? timeout : Duration.zero,
    (longest, value) => value > longest ? value : longest,
  );

  final String _url;
  final fvp.Player Function() _createPlayer;
  fvp.Player? _player;
  final List<StreamSubscription<dynamic>> _subscriptions = [];
  // Resolves after the previous native player and texture finish disposing;
  // the next session waits for it before creating another native player.
  Future<void> _teardown = Future<void>.value();
  // Kept while updateTexture is pending so teardown can wait for it before
  // disposing the native player. This avoids a texture being created after
  // disposal has already tried to release it.
  Future<int>? _textureUpdate;
  // Idle grace timer: armed only after the final active lease pauses. Resume
  // cancels it; expiry releases the native player while keeping this wrapper.
  Timer? _releaseTimer;
  // Retry backoff timer: scheduled after a playback error, and canceled when
  // playback pauses or the current session is otherwise stopped.
  Timer? _retryTimer;
  // Startup watchdog (single shot, 20s) and playback watchdog (periodic, 5s).
  // Startup expiry handles a hung prepare; periodic checks detect 20s stalls.
  Timer? _watchdog;
  int _generation = 0;
  // Increases on consecutive reconnect failures; successful playback resets it.
  int _retryAttempt = 0;
  // True only after preparation and texture setup complete for the current
  // native session; false while starting, paused-before-timeout, or torn down.
  bool _isInitialized = false;
  // Drives the UI error indicator after a failed active playback attempt.
  bool _hasError = false;
  // Permanent terminal state set by dispose; prevents new native sessions.
  bool _isDisposed = false;
  // Whether at least one lease currently requests playback. False during the
  // paused grace period, even though a prepared native player may still exist.
  bool _shouldPlay = false;
  // Prevents overlapping _start calls while a native session is being prepared.
  bool _starting = false;
  Size? _videoSize;

  @override
  bool get isInitialized => _isInitialized;
  @override
  bool get hasError => _hasError;
  @override
  Size? get videoSize => _videoSize;
  @override
  int? get textureId => _player?.textureId.value;

  // Async preparation and texture creation can outlive pause or teardown.
  // Only callbacks from the current native session may update this wrapper.
  bool _isCurrent(int generation) => !_isDisposed && generation == _generation;

  /// Creates and prepares a native player for the current playback request.
  /// Generation checks discard late results after pause, failure, or disposal.
  Future<void> _start() async {
    if (_starting || _player != null || !_shouldPlay || _isDisposed) return;
    _starting = true;
    final generation = ++_generation;
    try {
      await _teardown;
      if (!_isCurrent(generation) || !_shouldPlay) return;
      final player = _createPlayer();
      // Keep the native handle for texture access and to reuse this session if
      // playback resumes before the idle timeout expires.
      _player = player;
      _configure(player);
      _subscriptions.add(
        player.onMediaStatus.listen((event) {
          if (_isCurrent(generation) &&
              event.newValue.test(fvp.MediaStatus.invalid)) {
            _fail(generation);
          }
        }),
      );
      _subscriptions.add(
        player.onStateChanged.listen((event) {
          if (_isCurrent(generation) &&
              _isInitialized &&
              event.newValue == fvp.PlaybackState.stopped) {
            _fail(generation);
          }
        }),
      );
      _subscriptions.add(
        player.onEvent.listen((event) {
          // Buffering progress and decoder fallback events are not fatal errors.
          if (event.category != 'reader.buffering' && event.error != 0) {
            debugPrint(
              '[FvpRtspPlayer] ${event.category}: '
              '${event.detail} (${event.error})',
            );
          }
        }),
      );
      player.media = _url;
      // Give RTSP startup up to 20 seconds to prepare a frame and texture.
      _watchdog = Timer(const Duration(seconds: 20), () => _fail(generation));
      await _prepare(player, generation);
    } catch (error) {
      if (_isCurrent(generation)) {
        debugPrint('[FvpRtspPlayer] Failed to start: $error');
        _fail(generation);
      }
    } finally {
      if (generation == _generation) _starting = false;
    }
  }

  void _configure(fvp.Player player) {
    player.loop = 0;
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.linux) {
      player.videoDecoders = ['V4L2M2M', 'rockchip'];
    } else if (!kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.macOS ||
            defaultTargetPlatform == TargetPlatform.iOS)) {
      player.videoDecoders = ['VT', 'FFmpeg'];
    }
    // Prefer RTSP over TCP and recover from transient network interruptions.
    player.setProperty('video.decoder', 'shader_resource=0');
    player.setProperty('avformat.strict', 'experimental');
    player.setProperty('avformat.safe', '0');
    player.setProperty('avformat.extension_picky', '0');
    player.setProperty('avformat.allowed_segment_extensions', 'ALL');
    player.setProperty('avformat.rtsp_transport', 'tcp');
    player.setProperty('avio.reconnect', '1');
    player.setProperty('avio.reconnect_delay_max', '7');
    // Live camera streams should favor current frames over buffered ones.
    player.setProperty('avformat.fflags', '+nobuffer');
    player.setProperty('avformat.fpsprobesize', '0');
    player.setProperty('avformat.analyzeduration', '100000');
    player.setBufferRange(min: 0, max: 1000, drop: true);
  }

  Future<void> _prepare(fvp.Player player, int generation) async {
    final result = await player.prepare();
    if (!_isCurrent(generation)) return;
    if (result < 0) throw StateError('Media preparation failed');
    final size = await player.textureSize;
    if (!_isCurrent(generation)) return;
    if (size == null) throw StateError('Video size unavailable');
    final update = player.updateTexture();
    _textureUpdate = update;
    final id = await update;
    if (!_isCurrent(generation)) return;
    _textureUpdate = null;
    if (id < 0) throw StateError('Texture creation failed');
    _videoSize = size;
    _isInitialized = true;
    _hasError = false;
    // RTSP is live: freezing its decoder leaves it behind the live edge. Keep
    // reading and decoding during the grace period so a quick visibility
    // return shows current frames immediately. The idle timer releases this
    // native session when no lease wants playback for long enough.
    player.state = fvp.PlaybackState.playing;
    _watchdog?.cancel();
    if (_shouldPlay) _watchPlayback(player, generation);
    notifyListeners();
  }

  void _watchPlayback(fvp.Player player, int generation) {
    var lastPosition = player.position;
    var stalledSeconds = 0;
    _watchdog?.cancel();
    // Check every 5 seconds; reconnect after four checks show no position
    // progress. This timer is replaced on resume and canceled on pause/stop.
    _watchdog = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!_isCurrent(generation) || !_shouldPlay) return;
      final position = player.position;
      stalledSeconds = position == lastPosition ? stalledSeconds + 5 : 0;
      if (position != lastPosition) _retryAttempt = 0;
      lastPosition = position;
      if (stalledSeconds >= 20) _fail(generation);
    });
  }

  void _fail(int generation) {
    if (!_isCurrent(generation)) return;
    _stop();
    _hasError = true;
    // Consecutive failures wait 1, 2, 4, then 8 seconds between reconnects.
    // Position progress resets the attempt count; pausing cancels the retry.
    final delay = 1 << _retryAttempt.clamp(0, 3);
    _retryAttempt++;
    if (_shouldPlay) {
      _retryTimer = Timer(Duration(seconds: delay), () {
        unawaited(_start());
      });
    }
    notifyListeners();
  }

  void _stop() {
    // Invalidate callbacks before canceling streams and beginning native
    // disposal, since async completions can arrive during teardown.
    ++_generation;
    _starting = false;
    _releaseTimer?.cancel();
    _retryTimer?.cancel();
    _watchdog?.cancel();
    for (final subscription in _subscriptions) {
      unawaited(subscription.cancel());
    }
    _subscriptions.clear();
    final player = _player;
    final textureUpdate = _textureUpdate;
    // Clear the active session reference before asynchronous disposal. The UI
    // immediately stops exposing its texture; this local keeps the old native
    // player alive until _release completes. A later play can create a new one.
    _player = null;
    _textureUpdate = null;
    _isInitialized = false;
    _videoSize = null;
    if (player != null) {
      _teardown = _release(player, textureUpdate);
    }
  }

  Future<void> _release(fvp.Player player, Future<int>? textureUpdate) async {
    // Texture creation may race with pause or failure. Wait for it to settle so
    // disposal can release any texture it created.
    try {
      await textureUpdate;
    } catch (_) {
      // Failed creation still requires native cleanup.
    }
    try {
      await player.disposeAsync();
    } catch (error) {
      debugPrint('[FvpRtspPlayer] Failed to dispose: $error');
    }
  }

  @override
  void play() {
    if (_isDisposed || _shouldPlay) return;
    _shouldPlay = true;
    _releaseTimer?.cancel();
    final player = _player;
    if (player != null && _isInitialized) {
      // Native playback stayed at the live edge while hidden; resume stall
      // monitoring and render from the existing texture.
      _watchPlayback(player, _generation);
    } else if (_starting) {
      _watchdog?.cancel();
      final generation = _generation;
      _watchdog = Timer(const Duration(seconds: 20), () => _fail(generation));
    } else {
      unawaited(_start());
    }
  }

  @override
  void pause() {
    if (_isDisposed || !_shouldPlay) return;
    _shouldPlay = false;
    _retryTimer?.cancel();
    _watchdog?.cancel();
    // Stop stall monitoring while hidden, but keep the live decoder running
    // during the grace period. Freezing RTSP decoding delays recovery and can
    // leave playback at a low frame rate while it catches up to a keyframe.
    _scheduleRelease();
    _hasError = false;
    _retryAttempt = 0;
    notifyListeners();
  }

  void _scheduleRelease() {
    _releaseTimer?.cancel();
    _releaseTimer = Timer(_releaseTimeout, () {
      if (_isDisposed || _shouldPlay) return;
      // Release native resources while keeping this Dart wrapper available to
      // its leases. A later play request creates a fresh native session.
      _stop();
      notifyListeners();
    });
  }

  @override
  void dispose() {
    if (_isDisposed) return;
    _isDisposed = true;
    _shouldPlay = false;
    _stop();
    super.dispose();
  }
}
