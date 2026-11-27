import 'package:vision/widgets/media/player_lease.dart';
import 'package:vision/widgets/media/player_pool.dart';
import 'package:vision/widgets/media/rtsp/rtsp_player.dart';

typedef RtspPlayerLease = PlayerLease<String, RtspPlayer>;

/// Process-wide RTSP players indexed by stream URL.
///
/// Widgets for the same URL share one player. RTSP entries are evicted when
/// their last lease is released; a paused but still mounted player is retained
/// by its lease until that player's idle timeout expires.
class RtspPlayerPool {
  RtspPlayerPool._();

  static final PlayerPool<String, RtspPlayer> instance =
      PlayerPool<String, RtspPlayer>(
        createPlayer: RtspPlayer.new,
        disposeOnLastRelease: true,
      );
}
