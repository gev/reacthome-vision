import 'package:flutter/widgets.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class MediaPlayer extends StatefulWidget {
  final String url;

  const MediaPlayer({required this.url, super.key});

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
      native.setProperty('profile', 'low-latency');
      native.setProperty('untimed', '');
      native.setProperty('no-cache', '');
      native.setProperty('demuxer-max-bytes', '1024');
    }

    controller = VideoController(player);

    player.open(
      Media(
        widget.url,
        extras: {
          'rtsp-transport': 'tcp',
          'stimeout': '2000000',
          'allowed_media_types': 'video',
        },
      ),
    );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Video(controller: controller);
  }
}
