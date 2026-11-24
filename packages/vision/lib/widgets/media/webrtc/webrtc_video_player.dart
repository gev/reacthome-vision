import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:vision/widgets/media/player_lease.dart';
import 'package:vision/widgets/media/player_pool.dart';
import 'package:vision/widgets/media/webrtc/webrtc_ice_server.dart';
import 'package:vision/widgets/media/webrtc/webrtc_ice_transport_policy.dart';
import 'package:vision/widgets/media/webrtc/webrtc_player.dart';

/// Displays an established WebRTC stream and pauses rendering when hidden.
class WebRtcVideoPlayer<P extends WebRtcPlayer> extends StatefulWidget {
  final PlayerPool<String, P> playerPool;
  final String sessionId;
  final double? width;
  final double? height;
  final BoxFit fit;
  final List<WebRtcIceServer> iceServers;
  final WebRtcIceTransportPolicy iceTransportPolicy;
  final VoidCallback onStart;
  final VoidCallback? onPlay;
  final VoidCallback? onPause;
  final VoidCallback? onStop;

  const WebRtcVideoPlayer({
    super.key,
    required this.playerPool,
    required this.sessionId,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.iceServers = const [],
    this.iceTransportPolicy = WebRtcIceTransportPolicy.all,
    required this.onStart,
    this.onPlay,
    this.onPause,
    this.onStop,
  });

  @override
  State<WebRtcVideoPlayer<P>> createState() => _WebRtcVideoPlayerState<P>();
}

class _WebRtcVideoPlayerState<P extends WebRtcPlayer<dynamic>>
    extends State<WebRtcVideoPlayer<P>> {
  final Key _visibilityKey = UniqueKey();
  late PlayerLease<String, P> _lease;
  P get _player => _lease.player;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _lease = _acquire(widget);
  }

  @override
  void didUpdateWidget(WebRtcVideoPlayer<P> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.sessionId != widget.sessionId ||
        oldWidget.playerPool != widget.playerPool) {
      _lease.release();
      _lease = _acquire(widget);
      if (_isVisible) _lease.play();
    } else {
      _player.configure(
        iceServers: widget.iceServers,
        iceTransportPolicy: widget.iceTransportPolicy,
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

PlayerLease<String, P> _acquire<P extends WebRtcPlayer<dynamic>>(
  WebRtcVideoPlayer<P> widget,
) => widget.playerPool.acquire(
  widget.sessionId,
  configurePlayer: (player) {
    player.configure(
      iceServers: widget.iceServers,
      iceTransportPolicy: widget.iceTransportPolicy,
      onStart: widget.onStart,
      onPlay: widget.onPlay,
      onPause: widget.onPause,
      onStop: widget.onStop,
    );
  },
);
