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
      // 1. Аппаратное декодирование для Raspberry Pi 4 (v4l2m2m)
      native.setProperty('hwdec', 'v4l2m2m-copy');

      // 2. Базовый низколатентный профиль mpv
      native.setProperty('profile', 'low-latency');

      // 3. Отключаем файловый кэш, но оставляем разумный минимум для демуксера
      native.setProperty('cache', 'no');
      // ~512КБ достаточно для захвата I-frame без накопления задержки
      native.setProperty('demuxer-max-bytes', '524288');
      native.setProperty('demuxer-readahead-secs', '0');

      // 4. Синхронизация и дроп отстающих кадров
      native.setProperty('video-sync', 'desync');
      native.setProperty('framedrop', 'vo');
    }

    controller = VideoController(player);

    player.open(
      Media(
        widget.url,
        extras: {
          // Принудительный TCP транспорт для устранения артефактов UDP
          'rtsp_transport': 'tcp',

          // Флаги FFmpeg для минимизации задержки
          'fflags': 'nobuffer+fastseek',
          'flags': 'low_delay',

          // Уменьшаем время анализа потока при старте (в микросекундах: 500ms / 500KB)
          'analyzeduration': '500000',
          'probesize': '500000',

          // Таймаут подключения (5 секунд), чтобы не вешать UI при отвале камеры
          'stimeout': '5000000',
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
