import 'package:vision/pub_sub/request.dart';
import 'package:vision/stores/put.dart';

class Subscriber<K, V> {
  final Map<K, Set<Put<K, V>>> _stores = {};
  final SubscribeRequest<K> _subscribe;

  Subscriber({required this._subscribe});

  void subscribe(K key, Put<K, V> store) {
    final stores = _stores[key];
    if (stores == null) {
      _stores[key] = {store};
      _subscribe.subscribeOne(key);
    } else {
      stores.add(store);
    }
  }

  void reSubscribeAll() {
    if (_stores.isNotEmpty) {
      _subscribe.subscribeMany(_stores.keys);
    }
  }

  void publish(K key, V value) {
    final stores = _stores[key];
    if (stores != null) {
      for (final s in stores) {
        s.put(key, value);
      }
    }
  }
}

class DynamicSubscriber<K, V> extends Subscriber<K, V> {
  final UnsubscribeRequest<K> _unsubscribe;

  DynamicSubscriber({required super.subscribe, required this._unsubscribe});

  void unsubscribe(K key) {
    _unsubscribe.unsubscribeOne(key);
    _stores.remove(key);
  }

  void unsubscribeAll() {
    _unsubscribe.unsubscribeMany(_stores.keys);
    _stores.clear();
  }
}
