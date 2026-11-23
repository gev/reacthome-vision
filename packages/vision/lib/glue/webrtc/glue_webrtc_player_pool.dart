import 'package:vision/glue/webrtc/glue_webrtc_player.dart';
import 'package:vision/widgets/media/player_pool.dart';

/// WebRTC players whose candidates are represented as Glue objects.
final PlayerPool<String, GlueWebRtcPlayer> webRtcPlayerPool =
    PlayerPool<String, GlueWebRtcPlayer>(
      createPlayer: GlueWebRtcPlayer.new,
      onFirstAcquire: (player) => player.start(),
      onLastRelease: (player) => player.stop(),
    );
