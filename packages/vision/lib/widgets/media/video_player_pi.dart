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

  @override
  void didUpdateWidget(MediaPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url || oldWidget.pipeline != widget.pipeline) {
      _reinitializePlayer();
    }
  }

  Future<void> _reinitializePlayer() async {
    // 1. Отписываемся и освобождаем старый контроллер
    _controller.removeListener(_onControllerUpdated);
    await _controller.dispose();

    // 2. Инициализируем новый
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    _controller = FlutterpiVideoPlayerController.withGstreamerPipeline(
      widget.pipeline,
      formatHint: VideoFormat.other,
    );
    _controller.addListener(_onControllerUpdated);
    await _controller.initialize();
    setState(() {});
    await _controller.play();
  }

  void _onControllerUpdated() {
    if (mounted) setState(() {});
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
