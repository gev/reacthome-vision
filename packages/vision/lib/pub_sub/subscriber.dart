import 'package:flutter/widgets.dart';
import 'package:vision/pub_sub/request.dart';
import 'package:vision/stores/store.dart';

class Subscriber<K, V, R> {
  final Map<K, Set<Store<K, V, R>>> _stores = {};

  final Request<K> _request;

  Subscriber({required this._request});

  void subscribe(K key, Store<K, V, R> store) {
    final stores = _stores[key];
    if (stores == null) {
      _stores[key] = {store};
      _request.subscribeOne(key);
    } else {
      stores.add(store);
    }
  }

  void reSubscribeAll() {
    if (_stores.isEmpty) return;
    final snapshot = _stores.keys.toList();
    _request.subscrybeMany(snapshot);
  }

  void unsubscribe(K key) {
    _stores.remove(key);
    // ToDo: send unsubcribe request
  }

  void unsubscribeAll() {
    _stores.clear();
    // ToDo: send unsubcribe request
  }

  void publish(K key, V value) {
    final stores = _stores[key];
    if (stores != null) {
      for (final s in stores) {
        s.store(key, value);
      }
    }
  }
}

typedef ReactiveSubscriber<K, V> = Subscriber<K, V, ValueNotifier<V>>;
