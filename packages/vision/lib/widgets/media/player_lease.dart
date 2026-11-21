import 'package:vision/widgets/media/player.dart';

abstract interface class PlayerLeaseOwner<K, P extends Player> {
  void play(PlayerLease<K, P> lease);
  void pause(PlayerLease<K, P> lease);
  void release(PlayerLease<K, P> lease);
}

/// A unique claim on a player stored under [key].
class PlayerLease<K, P extends Player> {
  PlayerLease.create(this.key, this.player, this._pool, this.id);

  final K key;
  final P player;
  final PlayerLeaseOwner<K, P> _pool;
  final int id;
  bool isReleased = false;

  void invalidate() => isReleased = true;

  void play() => _pool.play(this);
  void pause() => _pool.pause(this);
  void release() => _pool.release(this);
}
