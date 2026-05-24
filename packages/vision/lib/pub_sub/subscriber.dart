import 'dart:async';

import 'package:vision/pub_sub/request.dart';
import 'package:vision/stores/store.dart';

class Subscriber<K, V, R> {
  final Set<K> _keys = {};
  final Set<K> _pending = {};

  final Store<K, V, R> _store;
  final Request<K> _request;
  final Duration _timeout;

  Subscriber({
    required this._store,
    required this._request,
    this._timeout = const Duration(seconds: 3),
  });

  R subscribe(K key, V defaultValue) {
    if (!_keys.contains(key) && !_pending.contains(key)) {
      _keys.add(key);
      _pending.add(key);
      _request.subscribeOne(key);
      Timer(_timeout, () {
        _pending.remove(key);
      });
    }
    return _store.lookup(key, defaultValue);
  }

  void reSubscribeAll() {
    if (_keys.isEmpty) return;
    _pending.clear();
    final snapshot = _keys.toList();
    _pending.addAll(snapshot);
    _request.subscrybeMany(snapshot);
    Timer(_timeout * snapshot.length, () {
      _pending.removeAll(snapshot);
    });
  }

  void unsubscribe(K key) {
    _keys.remove(key);
    _pending.remove(key);
    // ToDo: send unsubcribe request
  }

  void unsubscribeAll() {
    _keys.clear();
    _pending.clear();
    // ToDo: send unsubcribe request
  }

  void publish(K key, V value) {
    if (_keys.contains(key)) {
      _pending.remove(key);
      _store.store(key, value);
    }
  }
}
