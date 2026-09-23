import 'package:flutter/widgets.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class MediaPlayer extends StatefulWidget {
  final String url;

  final double? width;
  final double? height;
  final BoxFit fit;
  final Color fill;
  final Alignment alignment;
  final double? aspectRatio;
  final FilterQuality filterQuality;
  final Widget Function(VideoState)? controls;
  final bool wakelock;
  final bool pauseUponEnteringBackgroundMode;
  final bool resumeUponEnteringForegroundMode;
  final SubtitleViewConfiguration subtitleViewConfiguration;
  final Future<void> Function() onEnterFullscreen;
  final Future<void> Function() onExitFullscreen;
  final FocusNode? focusNode;

  const MediaPlayer({
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.fill = const Color(0xFF000000),
    this.alignment = Alignment.center,
    this.aspectRatio,
    this.filterQuality = FilterQuality.none,
    this.controls = NoVideoControls,
    this.wakelock = true,
    this.pauseUponEnteringBackgroundMode = true,
    this.resumeUponEnteringForegroundMode = false,
    this.subtitleViewConfiguration = const SubtitleViewConfiguration(),
    this.onEnterFullscreen = defaultEnterNativeFullscreen,
    this.onExitFullscreen = defaultExitNativeFullscreen,
    this.focusNode,
    super.key,
  });

  @override
  State<MediaPlayer> createState() => MediaPlayerState();
}

class MediaPlayerState extends State<MediaPlayer> {
  late final Player player;

  late final VideoController controller;

  @override
  void initState() {
    super.initState();

    player = Player();

    if (player.platform is NativePlayer) {
      final native = player.platform as NativePlayer;
      // Свойства libmpv для жесткого сброса кэша и задержек
      native.setProperty('profile', 'low-latency');
      native.setProperty('cache', 'no');
      // сжимаем буфер до 1 Кб
      native.setProperty('demuxer-max-bytes', '1024');
      // убираем упреждающее чтение
      native.setProperty('demuxer-readahead-secs', '0');
      native.setProperty('stream-buffer', 'no');
      // или 'audio' для подгонки кадров    }
      native.setProperty('video-sync', 'desync');
    }

    controller = VideoController(player);

    player.open(
      Media(
        widget.url,
        extras: {
          'rtsp_transport': 'tcp',
          // сбрасываем буферизацию на уровне ffmpeg
          'fflags': 'nobuffer+flags-un_latency+fastseek',
          // 'fflags': 'nobuffer+flags-un_latency',
          // флаг низкой задержки кодека
          'flags': 'low_delay',
          'max_delay': '0',
          // разрешаем дропать кадры при отставании
          // 'framedrop': '',
          'framedrop': 'lasso',
          'probesize': '32',
          'analyzeduration': '0',
          // // 'stimeout': '2000000',
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Video(
      controller: controller,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      fill: widget.fill,
      alignment: widget.alignment,
      aspectRatio: widget.aspectRatio,
      filterQuality: widget.filterQuality,
      controls: widget.controls,
      wakelock: widget.wakelock,
      pauseUponEnteringBackgroundMode: widget.pauseUponEnteringBackgroundMode,
      resumeUponEnteringForegroundMode: widget.resumeUponEnteringForegroundMode,
      subtitleViewConfiguration: widget.subtitleViewConfiguration,
      onEnterFullscreen: widget.onEnterFullscreen,
      onExitFullscreen: widget.onExitFullscreen,
      focusNode: widget.focusNode,
    );
  }

  @override
  void dispose() {
    try {
      player.dispose();
    } catch (_) {}
    super.dispose();
  }
}
