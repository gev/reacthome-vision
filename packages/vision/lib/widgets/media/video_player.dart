import 'package:flutter/material.dart';
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
  VideoPlayerController? _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  @override
  void didUpdateWidget(MediaPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url) {
      _reinitializePlayer();
    }
  }

  Future<void> _reinitializePlayer() async {
    setState(() {
      _isInitialized = false;
    });
    final oldController = _controller;
    if (oldController != null) {
      oldController.removeListener(_onControllerUpdated);
      await oldController.dispose();
    }
    await _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    final controller = VideoPlayerController.networkUrl(Uri.parse(widget.url));

    controller.addListener(_onControllerUpdated);

    try {
      await controller.initialize();

      if (mounted) {
        setState(() {
          _controller = controller;
          _isInitialized = true;
        });

        await controller.play();
      } else {
        await controller.dispose();
      }
    } catch (e, stack) {
      debugPrint('[GStreamer ERROR] Failed to initialize: $e');
      debugPrint(stack.toString());

      if (mounted) {
        setState(() {
          _isInitialized = false;
          _controller = null;
        });
      }
      await controller.dispose();
    }
  }

  void _onControllerUpdated() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller?.removeListener(_onControllerUpdated);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;

    if (!_isInitialized || controller == null) {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    final videoSize = controller.value.size;

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ClipRect(
        child: FittedBox(
          fit: widget.fit,
          child: SizedBox(
            width: videoSize.width,
            height: videoSize.height,
            child: VideoPlayer(controller, key: ValueKey(controller)),
          ),
        ),
      ),
    );
  }
}
