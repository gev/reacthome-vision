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

  bool _isInitialized = false;
  bool _hasError = false;
  bool _textureCreationStarted = false;
  bool _isDisposed = false;
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
    _statusSubscription = _player.onMediaStatus.listen((event) {
      if (event.newValue.test(fvp.MediaStatus.invalid)) {
        _showError();
      } else if (event.newValue.test(fvp.MediaStatus.loaded)) {
        _createTexture();
      }
    });
    _eventSubscription = _player.onEvent.listen((event) {
      // reader.buffering uses error as a 0..100 progress value, not an error.
      if (event.category != 'reader.buffering' && event.error != 0) {
        debugPrint(
          '[FvpRtspPlayer] ${event.category}: ${event.detail} (${event.error})',
        );
      }
    });

    // Prefer RTSP over TCP and recover from transient network interruptions.
    _player.setProperty('avformat.rtsp_transport', 'tcp');
    _player.setProperty('avio.reconnect', '1');
    _player.setProperty('avio.reconnect_delay_max', '7');
    // Live camera streams should favor current frames over buffered ones.
    _player.setProperty('avformat.fflags', '+nobuffer');
    _player.setProperty('avformat.fpsprobesize', '0');
    _player.setProperty('avformat.analyzeduration', '100000');
    _player.setBufferRange(min: 0, max: 1000, drop: true);
    _player.media = url;
    _player.state = fvp.PlaybackState.paused;
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
    _player.state = fvp.PlaybackState.playing;
  }

  @override
  void pause() {
    if (_isDisposed) return;
    _player.state = fvp.PlaybackState.paused;
  }

  @override
  void dispose() {
    _isDisposed = true;
    _statusSubscription?.cancel();
    _eventSubscription?.cancel();
    _player.dispose();
    super.dispose();
  }
}
