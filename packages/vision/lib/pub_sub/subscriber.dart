import 'package:vision/pub_sub/request.dart';
import 'package:vision/stores/put.dart';

class Subscriber<K, V> {
  final Map<K, Set<Put<K, V>>> _stores = {};

  final Request<K> _request;

  Subscriber({required this._request});

  void subscribe(K key, Put<K, V> store) {
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
        s.put(key, value);
      }
    }
  }
}
