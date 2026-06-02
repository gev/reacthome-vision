import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:vision/pub_sub/request.dart';
import 'package:vision/stores/store.dart';

class Subscriber<K, V, R> {
  final Map<K, Set<Store<K, V, R>>> _stores = {};
  final Set<K> _pending = {};

  final Request<K> _request;
  final Duration _timeout;

  Subscriber({
    required this._request,
    this._timeout = const Duration(seconds: 3),
  });

  void subscribe(K key, Store<K, V, R> store) {
    final stores = _stores[key];
    if (stores == null) {
      _stores[key] = {store};
      _pending.add(key);
      _request.subscribeOne(key);
      Timer(_timeout, () {
        _pending.remove(key);
      });
    } else {
      stores.add(store);
    }
  }

  void reSubscribeAll() {
    if (_stores.isEmpty) return;
    _pending.clear();
    final snapshot = _stores.keys.toList();
    _pending.addAll(snapshot);
    _request.subscrybeMany(snapshot);
    Timer(_timeout * snapshot.length, () {
      _pending.removeAll(snapshot);
    });
  }

  void unsubscribe(K key) {
    _stores.remove(key);
    _pending.remove(key);
    // ToDo: send unsubcribe request
  }

  void unsubscribeAll() {
    _stores.clear();
    _pending.clear();
    // ToDo: send unsubcribe request
  }

  void publish(K key, V value) {
    _pending.remove(key);
    final stores = _stores[key];
    if (stores != null) {
      for (final s in stores) {
        s.store(key, value);
      }
    }
  }
}

typedef ReactiveSubscriber<K, V> = Subscriber<K, V, ValueNotifier<V>>;
