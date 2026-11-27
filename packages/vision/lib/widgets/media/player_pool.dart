import 'dart:collection';

import 'package:vision/widgets/media/player.dart';
import 'package:vision/widgets/media/player_lease.dart';

/// Keeps one player per key and aggregates play requests across its leases.
class PlayerPool<K, P extends Player> implements PlayerLeaseOwner<K, P> {
  PlayerPool({
    required this._createPlayer,
    this.onFirstAcquire,
    this.onLastRelease,
    this.disposeOnLastRelease = false,
  });

  /// Evict unreferenced players instead of retaining them for later reuse.
  final bool disposeOnLastRelease;

  final P Function(K key) _createPlayer;
  final void Function(P player)? onFirstAcquire;
  final void Function(P player)? onLastRelease;
  final Map<K, _PooledPlayer<K, P>> _players = {};
  int _nextLeaseId = 0;

  PlayerLease<K, P> acquire(K key, {void Function(P player)? configurePlayer}) {
    final entry = _players.putIfAbsent(
      key,
      () => _PooledPlayer<K, P>(_createPlayer(key)),
    );
    configurePlayer?.call(entry.player);
    final isFirstLease = entry.leases.isEmpty;
    final lease = PlayerLease<K, P>.create(
      key,
      entry.player,
      this,
      ++_nextLeaseId,
    );
    entry.leases.add(lease);
    if (isFirstLease) onFirstAcquire?.call(entry.player);
    return lease;
  }

  /// Returns the cached player for [key], if one has already been acquired.
  P? getPlayer(K key) => _players[key]?.player;

  /// Removes and disposes [key]'s player only when no leases still own it.
  /// A caller can use this for delayed eviction after an idle grace period.
  void evictIfUnleased(K key) {
    final entry = _players[key];
    if (entry == null || entry.leases.isNotEmpty) return;
    _players.remove(key);
    onLastRelease?.call(entry.player);
    entry.player.dispose();
  }

  @override
  void play(PlayerLease<K, P> lease) {
    final entry = _entryFor(lease);
    if (entry == null || lease.isReleased) return;
    final wasAdded = entry.playingLeases.add(lease);
    if (entry.playingLeases.length == 1 || !wasAdded) entry.player.play();
  }

  @override
  void pause(PlayerLease<K, P> lease) {
    final entry = _entryFor(lease);
    if (entry == null || lease.isReleased) return;
    final wasPlaying = entry.playingLeases.remove(lease);
    if (wasPlaying && entry.playingLeases.isEmpty) entry.player.pause();
    if (!wasPlaying && entry.playingLeases.isEmpty) entry.player.pause();
  }

  @override
  void release(PlayerLease<K, P> lease) {
    if (lease.isReleased) return;
    lease.invalidate();
    final entry = _entryFor(lease);
    if (entry == null) return;
    entry.leases.remove(lease);
    entry.playingLeases.remove(lease);
    if (entry.playingLeases.isEmpty) entry.player.pause();
    if (entry.leases.isEmpty) {
      onLastRelease?.call(entry.player);
      if (disposeOnLastRelease) {
        _players.remove(lease.key);
        entry.player.dispose();
      }
    }
  }

  _PooledPlayer<K, P>? _entryFor(PlayerLease<K, P> lease) {
    final entry = _players[lease.key];
    return identical(entry?.player, lease.player) ? entry : null;
  }

  /// Disposes all cached players and invalidates their outstanding leases.
  void disposeAll() {
    for (final entry in _players.values) {
      if (entry.leases.isNotEmpty) onLastRelease?.call(entry.player);
      for (final lease in entry.leases) {
        lease.invalidate();
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
