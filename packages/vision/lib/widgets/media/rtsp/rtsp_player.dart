import 'dart:async';
import 'dart:ui' show Size;

import 'package:flutter/foundation.dart';
import 'package:fvp/mdk.dart' as fvp;
import 'package:vision/widgets/media/player.dart';

/// Owns fvp playback and exposes only the state needed by the UI.
class RtspPlayer extends Player {
  RtspPlayer(String url) {
    _initialize(url);
  }

  late final fvp.Player _player;
  StreamSubscription<({fvp.MediaStatus oldValue, fvp.MediaStatus newValue})>?
  _statusSubscription;
  StreamSubscription<fvp.MediaEvent>? _eventSubscription;
  StreamSubscription<({fvp.PlaybackState oldValue, fvp.PlaybackState newValue})>?
  _stateSubscription;

  bool _isInitialized = false;
  bool _hasError = false;
  bool _textureCreationStarted = false;
  bool _isDisposed = false;
  bool _shouldPlay = false;
  Size? _videoSize;

  @override
  bool get isInitialized => _isInitialized;
  @override
  bool get hasError => _hasError;
  @override
  Size? get videoSize => _videoSize;
  @override
  int? get textureId => _player.textureId.value;

  void _initialize(String url) {
    _player = fvp.Player();
    _player.loop = 0;
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.linux) {
      _player.videoDecoders = ['V4L2M2M', 'rockchip'];
    } else if (!kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.macOS ||
            defaultTargetPlatform == TargetPlatform.iOS)) {
      _player.videoDecoders = ['VT', 'FFmpeg'];
    }
    _statusSubscription = _player.onMediaStatus.listen((event) {
      debugPrint('[RtspPlayer] Media status: ${event.oldValue} -> ${event.newValue}');
      if (event.newValue.test(fvp.MediaStatus.invalid)) {
        _showError();
      }
    });
    _eventSubscription = _player.onEvent.listen((event) {
      if (event.category == 'decoder.video') {
        debugPrint('[RtspPlayer] Video decoder: ${event.detail} (${event.error})');
      }
      // reader.buffering uses error as a 0..100 progress value, not an error.
      if (event.category != 'reader.buffering' && event.error != 0) {
        debugPrint(
          '[FvpRtspPlayer] ${event.category}: ${event.detail} (${event.error})',
        );
      }
    });
    _stateSubscription = _player.onStateChanged.listen((event) {
      debugPrint('[RtspPlayer] State: ${event.oldValue} -> ${event.newValue}');
    });

    // Prefer RTSP over TCP and recover from transient network interruptions.
    _player.setProperty('video.decoder', 'shader_resource=0');
    _player.setProperty('avformat.strict', 'experimental');
    _player.setProperty('avformat.safe', '0');
    _player.setProperty('avformat.extension_picky', '0');
    _player.setProperty('avformat.allowed_segment_extensions', 'ALL');
    _player.setProperty('avformat.rtsp_transport', 'tcp');
    _player.setProperty('avio.reconnect', '1');
    _player.setProperty('avio.reconnect_delay_max', '7');
    // Live camera streams should favor current frames over buffered ones.
    _player.setProperty('avformat.fflags', '+nobuffer');
    _player.setProperty('avformat.fpsprobesize', '0');
    _player.setProperty('avformat.analyzeduration', '100000');
    _player.setBufferRange(min: 0, max: 1000, drop: true);
    _player.media = url;
    _prepare();
  }

  Future<void> _prepare() async {
    try {
      final result = await _player.prepare();
      debugPrint('[RtspPlayer] Prepare result: $result');
      if (_isDisposed) return;
      if (result < 0) {
        _showError();
        return;
      }
      await _createTexture();
      if (!_isDisposed && _isInitialized && _shouldPlay) {
        _player.state = fvp.PlaybackState.playing;
      }
    } catch (error, stack) {
      debugPrint('[FvpRtspPlayer] Failed to prepare: $error');
      debugPrint(stack.toString());
      _showError();
    }
  }

  Future<void> _createTexture() async {
    if (_textureCreationStarted || _isDisposed) return;
    _textureCreationStarted = true;

    try {
      final size = await _player.textureSize;
      if (_isDisposed) return;
      if (size == null) {
        _showError();
        return;
      }

      final id = await _player.updateTexture();
      debugPrint('[RtspPlayer] Texture: $id, size: ${size.width}x${size.height}');
      if (_isDisposed) return;
      if (id < 0) {
        _showError();
        return;
      }

      _videoSize = size;
      _isInitialized = true;
      _hasError = false;
      notifyListeners();
    } catch (error, stack) {
      debugPrint('[FvpRtspPlayer] Failed to create texture: $error');
      debugPrint(stack.toString());
      _showError();
    }
  }

  void _showError() {
    if (_isDisposed) return;
    _isInitialized = false;
    _hasError = true;
    _videoSize = null;
    notifyListeners();
  }

  @override
  void play() {
    if (_isDisposed) return;
    _shouldPlay = true;
    debugPrint('[RtspPlayer] Play requested, initialized=$_isInitialized');
    if (_isInitialized) _player.state = fvp.PlaybackState.playing;
  }

  @override
  void pause() {
    if (_isDisposed) return;
    _shouldPlay = false;
    debugPrint('[RtspPlayer] Pause requested, initialized=$_isInitialized');
    if (_isInitialized) _player.state = fvp.PlaybackState.paused;
  }

  @override
  void dispose() {
    _isDisposed = true;
    _statusSubscription?.cancel();
    _eventSubscription?.cancel();
    _stateSubscription?.cancel();
    _player.dispose();
    super.dispose();
  }
}
