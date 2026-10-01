import 'package:flutter/material.dart';
import 'package:flutterpi_gstreamer_video_player/flutterpi_gstreamer_video_player.dart';
import 'package:video_player/video_player.dart';

class MediaPlayer extends StatefulWidget {
  final String url;

  final double? width;
  final double? height;
  final BoxFit fit;

  const MediaPlayer({
    super.key,
    required this.url,
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
      'rtspsrc location="rtsp://192.168.31.170:554" ! queue max-size-buffers=2 ! rtph264depay ! h264parse ! decodebin ! autovideosink sync=false appsink name="sink"',
    );
    // _controller = VideoPlayerController.networkUrl(
    //   Uri.parse(widget.url),
    //   videoPlayerOptions: VideoPlayerOptions(
    //     mixWithOthers: true,
    //     allowBackgroundPlayback: false,
    //     backBufferDurationMs: 300,
    //   ),
    // );
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
