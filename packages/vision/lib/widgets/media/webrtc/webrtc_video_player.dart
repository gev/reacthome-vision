import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:vision/widgets/media/webrtc/webrtc_player.dart';
import 'package:vision/widgets/media/webrtc/webrtc_player_pool.dart';

/// Displays an established WebRTC stream and pauses rendering when hidden.
class WebRtcVideoPlayer extends StatefulWidget {
  final String streamId;
  final double? width;
  final double? height;
  final BoxFit fit;

  const WebRtcVideoPlayer({
    super.key,
    required this.streamId,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  @override
  State<WebRtcVideoPlayer> createState() => _WebRtcVideoPlayerState();
}

class _WebRtcVideoPlayerState extends State<WebRtcVideoPlayer> {
  final Key _visibilityKey = UniqueKey();
  late WebRtcPlayerLease _lease;
  WebRtcPlayer get _player => _lease.player;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _lease = webRtcPlayerPool.acquire(widget.streamId);
  }

  @override
  void didUpdateWidget(WebRtcVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.streamId != widget.streamId) {
      _lease.release();
      _lease = webRtcPlayerPool.acquire(widget.streamId);
      if (_isVisible) _lease.play();
    }
  }

  @override
  void dispose() {
    _lease.release();
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
          _lease.play();
        } else {
          _lease.pause();
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
