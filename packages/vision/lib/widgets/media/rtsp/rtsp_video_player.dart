import 'package:material_ui/material_ui.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:video_player/video_player.dart' as vp;
import 'package:vision/widgets/media/player.dart';
import 'package:vision/widgets/media/rtsp/rtsp_player_pool.dart';

/// Displays a pooled RTSP player through a unique playback lease.
class RtspVideoPlayer extends StatefulWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;

  const RtspVideoPlayer({
    super.key,
    required this.url,
    this.width,
    this.height,
    required this.fit,
  });

  @override
  State<RtspVideoPlayer> createState() => _RtspVideoPlayerState();
}

class _RtspVideoPlayerState extends State<RtspVideoPlayer> {
  final Key _visibilityKey = UniqueKey();
  late RtspPlayerLease _lease;
  Player get _player => _lease.player;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _lease = RtspPlayerPool.instance.acquire(widget.url);
  }

  @override
  void didUpdateWidget(RtspVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url) {
      _lease.release();
      _lease = RtspPlayerPool.instance.acquire(widget.url);
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
            final videoSize = _player.videoSize;
            if (_player.hasError) {
              return const Center(child: Icon(Icons.videocam_off_outlined));
            }
            if (!_player.isInitialized ||
                videoSize == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return ClipRect(
              child: FittedBox(
                fit: widget.fit,
                child: SizedBox(
                  width: videoSize.width,
                  height: videoSize.height,
                  child: vp.VideoPlayer(
                    _player.controller,
                    key: ValueKey(_player.controller),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
