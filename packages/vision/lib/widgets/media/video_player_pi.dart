import 'package:flutter/material.dart';
import 'package:flutterpi_gstreamer_video_player/flutterpi_gstreamer_video_player.dart';
import 'package:video_player/video_player.dart';

class MediaPlayer extends StatefulWidget {
  final String url;
  final String pipeline;

  final double? width;
  final double? height;
  final BoxFit fit;

  const MediaPlayer({
    super.key,
    required this.url,
    required this.pipeline,
    this.width,
    this.height,
    required this.fit,
  });

  @override
  State<MediaPlayer> createState() => _MediaPlayerState();
}

class _MediaPlayerState extends State<MediaPlayer> {
  late final VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    _controller = FlutterpiVideoPlayerController.withGstreamerPipeline(
      widget.pipeline,
      formatHint: VideoFormat.other,
    );
    _controller.addListener(() {
      setState(() {});
    });
    await _controller.initialize();
    setState(() {});
    await _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final videoSize = _controller.value.size;
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ClipRect(
        child: FittedBox(
          fit: widget.fit,
          child: SizedBox(
            width: videoSize.width,
            height: videoSize.height,
            child: VideoPlayer(_controller),
          ),
        ),
      ),
    );
  }
}
