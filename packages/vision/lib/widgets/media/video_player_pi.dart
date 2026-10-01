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
    final pipeline =
        'urisourcebin name=src uri="${widget.url}" buffer-mode=slave ! '
        'rtph264depay ! h264parse ! v4l2h264dec ! '
        'video/x-raw,format=I420 ! '
        'appsink name="sink" sync=false max-buffers=1 drop=true';
    _controller = FlutterpiVideoPlayerController.withGstreamerPipeline(
      pipeline,
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
