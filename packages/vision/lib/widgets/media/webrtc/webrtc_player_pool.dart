import 'package:vision/widgets/media/player_lease.dart';
import 'package:vision/widgets/media/player_pool.dart';
import 'package:vision/widgets/media/webrtc/webrtc_player.dart';

typedef WebRtcPlayerLease = PlayerLease<String, WebRtcPlayer>;

/// Shared WebRTC players keyed by application stream ID.
final PlayerPool<String, WebRtcPlayer> webRtcPlayerPool =
    PlayerPool<String, WebRtcPlayer>(
      createPlayer: WebRtcPlayer.new,
      onFirstAcquire: (player) => player.start(),
      onLastRelease: (player) => player.stop(),
    );
