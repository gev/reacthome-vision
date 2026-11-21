import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fvp/mdk.dart' as fvp;

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
  fvp.Player? _player;
  StreamSubscription<({fvp.MediaStatus oldValue, fvp.MediaStatus newValue})>?
  _statusSubscription;
  StreamSubscription<fvp.MediaEvent>? _eventSubscription;
  bool _isInitialized = false;
  bool _hasError = false;
  Size? _videoSize;
  int _generation = 0;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  @override
  void didUpdateWidget(VideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url) {
      _initializePlayer();
    }
  }

  Future<void> _initializePlayer() async {
    final generation = ++_generation;
    final oldPlayer = _player;
    _player = null;
    await _statusSubscription?.cancel();
    await _eventSubscription?.cancel();
    oldPlayer?.dispose();

    if (mounted) {
      setState(() {
        _isInitialized = false;
        _hasError = false;
      });
    }

    final player = fvp.Player();
    _player = player;

    _statusSubscription = player.onMediaStatus.listen((event) {
      if (generation != _generation) return;
      if (event.newValue.test(fvp.MediaStatus.loaded)) {
        _createTexture(player, generation);
      }
    });
    _eventSubscription = player.onEvent.listen((event) {
      if (generation == _generation && event.error != 0) {
        _showError(generation);
      }
    });

    // Prefer RTSP over TCP and recover from transient network interruptions.
    player.setProperty('avformat.rtsp_transport', 'tcp');
    player.setProperty('avio.reconnect', '1');
    player.setProperty('avio.reconnect_delay_max', '7');
    // Live camera streams should favor current frames over buffered ones.
    player.setProperty('avformat.fflags', '+nobuffer');
    player.setProperty('avformat.fpsprobesize', '0');
    player.setProperty('avformat.analyzeduration', '100000');
    player.setBufferRange(min: 0, max: 1000, drop: true);
    player.media = widget.url;
    player.state = fvp.PlaybackState.playing;
  }

  Future<void> _createTexture(fvp.Player player, int generation) async {
    try {
      final size = await player.textureSize;
      if (size == null || generation != _generation) {
        _showError(generation);
        return;
      }

      final textureId = await player.updateTexture();
      if (generation != _generation) return;
      if (textureId < 0) {
        _showError(generation);
        return;
      }

      setState(() {
        _isInitialized = true;
        _hasError = false;
        _videoSize = size;
      });
    } catch (error, stack) {
      debugPrint('[VideoPlayer] Failed to create texture: $error');
      debugPrint(stack.toString());
      _showError(generation);
    }
  }

  void _showError(int generation) {
    if (!mounted || generation != _generation) return;
    setState(() {
      _isInitialized = false;
      _hasError = true;
      _videoSize = null;
    });
  }

  @override
  void dispose() {
    ++_generation;
    _statusSubscription?.cancel();
    _eventSubscription?.cancel();
    _player?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final player = _player;
    final textureId = player?.textureId.value;
    final videoSize = _videoSize;

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: _hasError
          ? const Center(child: Icon(Icons.videocam_off_outlined))
          : !_isInitialized ||
                player == null ||
                textureId == null ||
                videoSize == null
          ? const Center(child: CircularProgressIndicator())
          : ClipRect(
              child: FittedBox(
                fit: widget.fit,
                child: SizedBox(
                  width: videoSize.width,
                  height: videoSize.height,
                  child: Texture(textureId: textureId),
                ),
              ),
            ),
    );
  }
}
