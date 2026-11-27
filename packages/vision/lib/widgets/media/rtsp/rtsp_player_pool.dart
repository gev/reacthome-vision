import 'package:vision/widgets/media/player_lease.dart';
import 'package:vision/widgets/media/player_pool.dart';
import 'package:vision/widgets/media/rtsp/rtsp_player.dart';

typedef RtspPlayerLease = PlayerLease<String, RtspPlayer>;

/// Process-wide RTSP players indexed by stream URL.
///
/// Widgets for the same URL share one player. RTSP entries are evicted when
/// their last lease is released. Native resources remain available during the
/// configured idle timeout, whether views are hidden or their screen closes;
/// the pool evicts the wrapper when that timeout expires without reacquisition.
class RtspPlayerPool {
  RtspPlayerPool._();

  static final PlayerPool<String, RtspPlayer> instance = _createPool();

  static PlayerPool<String, RtspPlayer> _createPool() {
    late final PlayerPool<String, RtspPlayer> pool;
    pool = PlayerPool<String, RtspPlayer>(
      createPlayer: (url) =>
          RtspPlayer(url, onIdle: () => pool.evictIfUnleased(url)),
    );
    return pool;
  }
}
