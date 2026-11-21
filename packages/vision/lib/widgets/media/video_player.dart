import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:vision/widgets/media/player.dart';
import 'package:vision/widgets/media/rtsp_player_pool.dart';

/// Displays a pooled RTSP player through a unique playback lease.
class VideoPlayer extends StatefulWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;

  const VideoPlayer({
    super.key,
    required this.url,
    this.width,
    this.height,
    required this.fit,
  });

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
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
  void didUpdateWidget(VideoPlayer oldWidget) {
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
        debugPrint(
          '[VideoPlayer] ${widget.url} visibility: '
          '${(info.visibleFraction * 100).toStringAsFixed(1)}%',
        );
        if (visible) {
          debugPrint('[VideoPlayer] ${widget.url}: play (visible)');
          _lease.play();
        } else {
          debugPrint('[VideoPlayer] ${widget.url}: pause (not visible)');
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
            final textureId = _player.textureId;

            if (_player.hasError) {
              return const Center(child: Icon(Icons.videocam_off_outlined));
            }
            if (!_player.isInitialized ||
                videoSize == null ||
                textureId == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return ClipRect(
              child: FittedBox(
                fit: widget.fit,
                child: SizedBox(
                  width: videoSize.width,
                  height: videoSize.height,
                  child: Texture(textureId: textureId),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
