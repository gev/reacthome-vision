import 'dart:collection';

import 'package:vision/widgets/media/player.dart';

/// A unique claim on a player stored under [key].
class PlayerLease<K, P extends Player> {
  PlayerLease._(this.key, this.player, this._pool, this.id);

  final K key;
  final P player;
  final PlayerPool<K, P> _pool;
  final int id;
  bool _released = false;

  void play() => _pool._play(this);
  void pause() => _pool._pause(this);
  void release() => _pool._release(this);
}

/// Keeps one player per key and aggregates play requests across its leases.
class PlayerPool<K, P extends Player> {
  PlayerPool({required P Function(K key) createPlayer})
      : _createPlayer = createPlayer;

  final P Function(K key) _createPlayer;
  final Map<K, _PooledPlayer<K, P>> _players = {};
  int _nextLeaseId = 0;

  PlayerLease<K, P> acquire(K key) {
    final entry = _players.putIfAbsent(
      key,
      () => _PooledPlayer<K, P>(_createPlayer(key)),
    );
    final lease = PlayerLease<K, P>._(key, entry.player, this, ++_nextLeaseId);
    entry.leases.add(lease);
    return lease;
  }

  void _play(PlayerLease<K, P> lease) {
    final entry = _entryFor(lease);
    if (entry == null || lease._released) return;
    final wasStopped = entry.playingLeases.isEmpty;
    entry.playingLeases.add(lease);
    if (wasStopped) entry.player.play();
  }

  void _pause(PlayerLease<K, P> lease) {
    final entry = _entryFor(lease);
    if (entry == null || lease._released) return;
    final wasPlaying = entry.playingLeases.remove(lease);
    if (wasPlaying && entry.playingLeases.isEmpty) entry.player.pause();
  }

  void _release(PlayerLease<K, P> lease) {
    if (lease._released) return;
    lease._released = true;
    final entry = _entryFor(lease);
    if (entry == null) return;
    entry.leases.remove(lease);
    final wasPlaying = entry.playingLeases.remove(lease);
    if (wasPlaying && entry.playingLeases.isEmpty) entry.player.pause();
  }

  _PooledPlayer<K, P>? _entryFor(PlayerLease<K, P> lease) {
    final entry = _players[lease.key];
    return identical(entry?.player, lease.player) ? entry : null;
  }

  /// Disposes all cached players and invalidates their outstanding leases.
  void disposeAll() {
    for (final entry in _players.values) {
      for (final lease in entry.leases) {
        lease._released = true;
      }
      entry.player.dispose();
    }
    _players.clear();
  }
}

class _PooledPlayer<K, P extends Player> {
  _PooledPlayer(this.player);

  final P player;
  final Set<PlayerLease<K, P>> leases = HashSet.identity();
  final Set<PlayerLease<K, P>> playingLeases = HashSet.identity();
}
