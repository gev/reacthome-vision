import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:vision/widgets/media/fvp_rtsp_player.dart';

/// Displays an [FvpRtspPlayer] while owning its lifecycle.
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
  late FvpRtspPlayer _player;

  @override
  void initState() {
    super.initState();
    _player = FvpRtspPlayer(widget.url);
  }

  @override
  void didUpdateWidget(VideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url) {
      _player.dispose();
      _player = FvpRtspPlayer(widget.url);
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
        debugPrint(
          '[VideoPlayer] ${widget.url} visibility: '
          '${(info.visibleFraction * 100).toStringAsFixed(1)}%',
        );
        if (visible) {
          debugPrint('[VideoPlayer] ${widget.url}: play (visible)');
          _player.play();
        } else {
          debugPrint('[VideoPlayer] ${widget.url}: pause (not visible)');
          _player.pause();
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
