import 'dart:async';
import 'dart:ui' show Size;

import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:vision/widgets/media/player.dart';

/// Owns rendering for a WebRTC stream identified by [streamId].
///
/// The peer connection and signaling remain the responsibility of the caller
/// that supplies the stream. This player owns only its video renderer.
class WebRtcPlayer extends Player {
  WebRtcPlayer(this.streamId) {
    _renderer.onResize = _handleResize;
    unawaited(_initialize());
  }

  final String streamId;
  final RTCVideoRenderer _renderer = RTCVideoRenderer();
  MediaStream? _stream;
  bool _rendererInitialized = false;
  bool _isInitialized = false;
  bool _hasError = false;
  bool _isPlaying = false;
  bool _isDisposed = false;
  int _sourceRevision = 0;

  @override
  bool get isInitialized => _isInitialized;

  @override
  bool get hasError => _hasError;

  @override
  int? get textureId => _renderer.textureId;

  MediaStream? get stream => _stream;

  @override
  Size? get videoSize {
    final width = _renderer.videoWidth;
    final height = _renderer.videoHeight;
    if (width <= 0 || height <= 0) return null;
    return Size(width.toDouble(), height.toDouble());
  }

  RTCVideoRenderer get renderer => _renderer;

  Future<void> _initialize() async {
    try {
      await _renderer.initialize();
      if (_isDisposed) return;
      _rendererInitialized = true;
      if (_isPlaying && _stream != null) {
        await _bindStream(_stream!);
      }
    } catch (error, stack) {
      debugPrint('[WebRtcPlayer] Failed to initialize renderer: $error');
      debugPrint(stack.toString());
      _showError();
    }
  }

  Future<void> setStream(MediaStream? stream) async {
    if (_isDisposed || identical(stream, _stream)) return;
    _stream = stream;
    _sourceRevision++;
    _isInitialized = false;
    _hasError = false;
    notifyListeners();
    if (!_rendererInitialized) return;
    if (_isPlaying && stream != null) {
      await _bindStream(stream);
    } else {
      await _detachStream(_sourceRevision);
    }
  }

  void _handleResize() {
    if (_isDisposed) return;
    final size = videoSize;
    if (size != null) {
      _isInitialized = true;
      _hasError = false;
    }
    notifyListeners();
  }

  @override
  void play() {
    if (_isDisposed || _isPlaying) return;
    _isPlaying = true;
    final stream = _stream;
    if (_rendererInitialized && stream != null) {
      unawaited(_bindStream(stream));
    }
  }

  @override
  void pause() {
    if (_isDisposed || !_isPlaying) return;
    _isPlaying = false;
    final revision = ++_sourceRevision;
    unawaited(_detachStream(revision));
  }

  Future<void> _bindStream(MediaStream stream) async {
    if (_isDisposed || !_rendererInitialized || !_isPlaying) return;
    final revision = ++_sourceRevision;
    try {
      await _renderer.setSrcObject(stream: stream);
      if (_isDisposed || revision != _sourceRevision) return;
      _hasError = false;
      notifyListeners();
    } catch (error, stack) {
      debugPrint('[WebRtcPlayer] Failed to bind media stream: $error');
      debugPrint(stack.toString());
      if (revision == _sourceRevision) _showError();
    }
  }

  Future<void> _detachStream(int revision) async {
    try {
      await _renderer.setSrcObject(stream: null);
      if (_isDisposed || revision != _sourceRevision) return;
      _isInitialized = false;
      notifyListeners();
    } catch (error, stack) {
      debugPrint('[WebRtcPlayer] Failed to detach media stream: $error');
      debugPrint(stack.toString());
      if (revision == _sourceRevision) _showError();
    }
  }

  void _showError() {
    if (_isDisposed) return;
    _isInitialized = false;
    _hasError = true;
    notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    _sourceRevision++;
    unawaited(_renderer.dispose());
    super.dispose();
  }
}
