import 'dart:ui' show Size;

import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:vision/widgets/media/player.dart';

/// Owns rendering for a WebRTC session identified by [sessionId].
///
/// The signaling transport remains the caller's responsibility.
class WebRtcPlayer extends Player {
  WebRtcPlayer(
    this.sessionId, {
    VoidCallback onStart = _noOp,
    VoidCallback? onPlay,
    VoidCallback? onPause,
    VoidCallback? onStop,
  }) {
    updateCallbacks(
      onStart: onStart,
      onPlay: onPlay,
      onPause: onPause,
      onStop: onStop,
    );
    _renderer.onResize = _handleResize;
    _initialize();
  }

  final String sessionId;
  late VoidCallback _onStart;
  VoidCallback? _onPlay;
  VoidCallback? _onPause;
  VoidCallback? _onStop;
  final RTCVideoRenderer _renderer = RTCVideoRenderer();
  RTCPeerConnection? _peerConnection;
  MediaStream? _stream;
  bool _rendererInitialized = false;
  bool _isInitialized = false;
  bool _hasError = false;
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

  /// Applies a remote JSEP offer and returns the local answer.
  Future<RTCSessionDescription> acceptOffer(
    RTCSessionDescription offer, {
    required void Function(RTCIceCandidate candidate) onIceCandidate,
  }) async {
    if (_isDisposed) throw StateError('WebRTC player is disposed');

    final peerConnection = _peerConnection ??= await createPeerConnection({});
    peerConnection.onIceCandidate = onIceCandidate;
    peerConnection.onTrack = (event) {
      if (event.streams.isEmpty) return;
      setStream(event.streams.first);
    };

    await peerConnection.setRemoteDescription(offer);
    final answer = await peerConnection.createAnswer();
    await peerConnection.setLocalDescription(answer);
    return await peerConnection.getLocalDescription() ?? answer;
  }

  void updateCallbacks({
    required VoidCallback onStart,
    VoidCallback? onPlay,
    VoidCallback? onPause,
    VoidCallback? onStop,
  }) {
    _onStart = onStart;
    _onPlay = onPlay;
    _onPause = onPause;
    _onStop = onStop;
  }

  void start() {
    if (_isDisposed) return;
    _onStart();
    final stream = _stream;
    if (_rendererInitialized && stream != null) {
      _bindStream(stream);
    }
  }

  Future<void> _initialize() async {
    try {
      await _renderer.initialize();
      if (_isDisposed) return;
      _rendererInitialized = true;
      if (_stream != null) {
        await _bindStream(_stream!);
      }
    } catch (error, stack) {
      debugPrint('[WebRtcPlayer] Failed to initialize renderer: $error');
      debugPrint(stack.toString());
      _showError();
    }
  }

  Future<void> setStream(MediaStream? stream) async {
    if (_isDisposed) return;
    final isSameStream = identical(stream, _stream);
    _stream = stream;
    _sourceRevision++;
    if (!isSameStream) _isInitialized = false;
    _hasError = false;
    notifyListeners();
    if (!_rendererInitialized) return;
    if (stream != null) {
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
    if (_isDisposed) return;
    _onPlay?.call();
    final stream = _stream;
    if (_rendererInitialized && stream != null) {
      _bindStream(stream);
    }
  }

  @override
  void pause() {
    if (_isDisposed) return;
    _onPause?.call();
  }

  void stop() {
    if (_isDisposed) return;
    _onStop?.call();
    final revision = ++_sourceRevision;
    _detachStream(revision);
  }

  Future<void> _bindStream(MediaStream stream) async {
    if (_isDisposed || !_rendererInitialized) return;
    final revision = ++_sourceRevision;
    try {
      await _renderer.setSrcObject(stream: stream);
      if (_isDisposed || revision != _sourceRevision) return;
      if (videoSize != null) _isInitialized = true;
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
    _peerConnection?.close();
    _renderer.dispose();
    super.dispose();
  }
}

void _noOp() {}
