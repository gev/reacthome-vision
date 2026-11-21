import 'package:flutter/material.dart';
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
    return SizedBox(
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
    );
  }
}
