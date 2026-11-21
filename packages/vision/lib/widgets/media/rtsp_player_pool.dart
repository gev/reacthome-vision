import 'package:vision/widgets/media/fvp_rtsp_player.dart';
import 'package:vision/widgets/media/player_pool.dart';

typedef RtspPlayerLease = PlayerLease<String, FvpRtspPlayer>;

/// RTSP player pool configuration used by the video widget.
class RtspPlayerPool {
  RtspPlayerPool._();

  static final PlayerPool<String, FvpRtspPlayer> instance =
      PlayerPool<String, FvpRtspPlayer>(
        createPlayer: FvpRtspPlayer.new,
      );
}
