import 'dart:async';

import 'package:vision/pub_sub/request.dart';
import 'package:vision/pub_sub/store.dart';

class Subscriber<K, V> {
  final Set<K> _keys = {};
  final Set<K> _pending = {};

  final Store<K, V> _store;
  final Request<K> _request;
  final Duration _timeout;

  Subscriber({
    required Store<K, V> store,
    required Request<K> request,
    Duration timeout = const Duration(seconds: 3),
  }) : _store = store,
       _request = request,
       _timeout = timeout;

  V? subscribe(K key) {
    if (!_keys.contains(key) && !_pending.contains(key)) {
      _keys.add(key);
      _pending.add(key);
      _request.one(key);
      Timer(_timeout, () {
        _pending.remove(key);
      });
    }
    return _store.lookup(key);
  }

  void reSubscribeAll() {
    if (_keys.isEmpty) return;
    _pending.clear();
    final snapshot = _keys.toList();
    _pending.addAll(snapshot);
    _request.many(snapshot);
    Timer(_timeout * snapshot.length, () {
      _pending.removeAll(snapshot);
    });
  }

  void unsubscribe(K key) {
    _keys.remove(key);
    _pending.remove(key);
  }

  void unsubscribeAll() {
    _keys.clear();
    _pending.clear();
  }

  void publish(K key, V value) {
    if (_keys.contains(key)) {
      _pending.remove(key);
      _store.store(key, value);
    }
  }
}
