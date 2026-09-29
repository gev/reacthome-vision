import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MediaPlayerPi extends StatefulWidget {
  final String url;

  const MediaPlayerPi({super.key, required this.url});

  @override
  State<MediaPlayerPi> createState() => _MediaPlayerPiState();
}

class _MediaPlayerPiState extends State<MediaPlayerPi> {
  VideoPlayerController? _controller;
  bool _hasError = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  @override
  void didUpdateWidget(covariant MediaPlayerPi oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url) {
      _disposeAndReinitialize();
    }
  }

  Future<void> _initializePlayer() async {
    setState(() {
      _hasError = false;
      _errorMessage = '';
    });

    try {
      final controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.url),
        videoPlayerOptions: VideoPlayerOptions(
          mixWithOthers: true,
          allowBackgroundPlayback: false,
        ),
      );

      _controller = controller;

      controller.addListener(() {
        if (controller.value.hasError && mounted) {
          setState(() {
            _hasError = true;
            _errorMessage =
                controller.value.errorDescription ?? 'Playback error';
          });
        }
      });

      await controller.initialize();
      await controller.setLooping(true);
      await controller.play();

      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _errorMessage = e.toString();
        });
      }
    }
  }

  Future<void> _disposeAndReinitialize() async {
    final oldController = _controller;
    _controller = null;
    await oldController?.dispose();
    await _initializePlayer();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 48),
          const SizedBox(height: 8),
          Text(
            'Stream Error: $_errorMessage',
            style: const TextStyle(color: Colors.white70),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: _disposeAndReinitialize,
            child: const Text('Retry'),
          ),
        ],
      );
    }

    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) {
      return const CircularProgressIndicator(color: Colors.white);
    }

    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: VideoPlayer(controller),
    );
  }
}
