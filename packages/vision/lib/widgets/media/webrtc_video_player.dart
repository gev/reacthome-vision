import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:vision/widgets/media/webrtc_player.dart';

/// Displays an established WebRTC stream and pauses rendering when hidden.
class WebRtcVideoPlayer extends StatefulWidget {
  final MediaStream stream;
  final double? width;
  final double? height;
  final BoxFit fit;

  const WebRtcVideoPlayer({
    super.key,
    required this.stream,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  @override
  State<WebRtcVideoPlayer> createState() => _WebRtcVideoPlayerState();
}

class _WebRtcVideoPlayerState extends State<WebRtcVideoPlayer> {
  final Key _visibilityKey = UniqueKey();
  late WebRtcPlayer _player;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _player = WebRtcPlayer(widget.stream);
  }

  @override
  void didUpdateWidget(WebRtcVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(oldWidget.stream, widget.stream)) {
      unawaited(_player.setStream(widget.stream));
      if (_isVisible) _player.play();
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _visibilityKey,
      onVisibilityChanged: (info) {
        final visible = info.visibleFraction > 0;
        _isVisible = visible;
        if (visible) {
          _player.play();
        } else {
          _player.pause();
        }
      },
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: AnimatedBuilder(
          animation: _player,
          builder: (context, _) {
            if (_player.hasError) {
              return const Center(child: Icon(Icons.videocam_off_outlined));
            }
            if (!_player.isInitialized || _player.videoSize == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return ClipRect(
              child: RTCVideoView(
                _player.renderer,
                objectFit: widget.fit == BoxFit.cover
                    ? RTCVideoViewObjectFit.RTCVideoViewObjectFitCover
                    : RTCVideoViewObjectFit.RTCVideoViewObjectFitContain,
              ),
            );
          },
        ),
      ),
    );
  }
}
