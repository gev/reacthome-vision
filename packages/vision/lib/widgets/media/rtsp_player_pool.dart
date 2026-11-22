import 'package:vision/widgets/media/player_lease.dart';
import 'package:vision/widgets/media/player_pool.dart';
import 'package:vision/widgets/media/rtsp_player.dart';

typedef RtspPlayerLease = PlayerLease<String, RtspPlayer>;

/// RTSP player pool configuration used by the video widget.
class RtspPlayerPool {
  RtspPlayerPool._();

  static final PlayerPool<String, RtspPlayer> instance =
      PlayerPool<String, RtspPlayer>(createPlayer: RtspPlayer.new);
}
