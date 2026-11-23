import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:vision/widgets/media/webrtc/webrtc_player.dart';
import 'package:vision/widgets/media/webrtc/webrtc_player_pool.dart';

/// Displays an established WebRTC stream and pauses rendering when hidden.
class WebRtcVideoPlayer extends StatefulWidget {
  final String sessionId;
  final double? width;
  final double? height;
  final BoxFit fit;
  final List<Map<String, dynamic>> iceServers;
  final VoidCallback onStart;
  final VoidCallback? onPlay;
  final VoidCallback? onPause;
  final VoidCallback? onStop;

  const WebRtcVideoPlayer({
    super.key,
    required this.sessionId,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.iceServers = const [],
    required this.onStart,
    this.onPlay,
    this.onPause,
    this.onStop,
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
    _lease = _acquire(widget);
  }

  @override
  void didUpdateWidget(WebRtcVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.sessionId != widget.sessionId) {
      _lease.release();
      _lease = _acquire(widget);
      if (_isVisible) _lease.play();
    } else {
      _player.updateIceServers(widget.iceServers);
      _player.updateCallbacks(
        onStart: widget.onStart,
        onPlay: widget.onPlay,
        onPause: widget.onPause,
        onStop: widget.onStop,
      );
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

WebRtcPlayerLease _acquire(WebRtcVideoPlayer widget) =>
    webRtcPlayerPool.acquire(
      widget.sessionId,
      configurePlayer: (player) {
        player.updateIceServers(widget.iceServers);
        player.updateCallbacks(
          onStart: widget.onStart,
          onPlay: widget.onPlay,
          onPause: widget.onPause,
          onStop: widget.onStop,
        );
      },
    );
