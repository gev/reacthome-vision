import 'dart:ui' show Size;

import 'package:flutter/foundation.dart';
import 'package:video_player/video_player.dart';
import 'package:vision/widgets/media/player.dart';

/// Owns the FVP-backed controller for an RTSP stream.
class RtspPlayer extends Player {
  RtspPlayer(String url) {
    _initialize(url);
  }

  late final VideoPlayerController controller;
  bool _isInitialized = false;
  bool _hasError = false;
  bool _isDisposed = false;
  bool _shouldPlay = false;

  @override
  bool get isInitialized => _isInitialized;

  @override
  bool get hasError => _hasError;

  @override
  Size? get videoSize =>
      _isInitialized ? controller.value.size : null;

  @override
  int? get textureId => null;

  Future<void> _initialize(String url) async {
    controller = VideoPlayerController.networkUrl(Uri.parse(url));
    controller.addListener(_handleControllerUpdate);
    try {
      await controller.initialize();
      if (_isDisposed) return;
      _isInitialized = true;
      _hasError = false;
      notifyListeners();
      if (_shouldPlay) controller.play();
    } catch (error, stack) {
      debugPrint('[FvpRtspPlayer] Failed to initialize: $error');
      debugPrint(stack.toString());
      if (_isDisposed) return;
      _hasError = true;
      notifyListeners();
    }
  }

  void _handleControllerUpdate() {
    if (_isDisposed) return;
    if (controller.value.hasError) {
      _hasError = true;
      _isInitialized = false;
    }
    notifyListeners();
  }

  @override
  void play() {
    if (_isDisposed) return;
    _shouldPlay = true;
    if (_isInitialized) controller.play();
  }

  @override
  void pause() {
    if (_isDisposed) return;
    _shouldPlay = false;
    if (_isInitialized) controller.pause();
  }

  @override
  void dispose() {
    _isDisposed = true;
    controller.removeListener(_handleControllerUpdate);
    controller.dispose();
    super.dispose();
  }
}
