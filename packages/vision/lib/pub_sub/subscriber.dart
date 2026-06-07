import 'package:vision/pub_sub/request.dart';
import 'package:vision/stores/put.dart';

class Subscriber<K, V> {
  final Map<K, Set<Put<K, V>>> _stores = {};
  final Request<K> _request;

  Subscriber({required this._request});

  bool get isEmpty => _stores.isEmpty;
  bool get isNotEmpty => !isEmpty;

  bool isSubscribed(K key) => _stores.containsKey(key);
  bool isUnsubscribet(K key) => !isSubscribed(key);

  void subscribe(K key, Put<K, V> store) {
    var stores = _stores[key];
    if (stores == null) {
      _stores[key] = {store};
      _request.subscribeOne(key);
    } else {
      stores.add(store);
    }
  }

  void resubscribeAll() {
    if (isNotEmpty) {
      _request.subscribeMany(_stores.keys);
    }
  }

  void unsubscribe(K key) {
    if (isSubscribed(key)) {
      _request.unsubscribeOne(key);
      _stores.remove(key);
    }
  }

  void unsubscribeAll() {
    if (isNotEmpty) {
      _request.unsubscribeMany(_stores.keys);
      _stores.clear();
    }
  }

  void publish(K key, V value) {
    final stores = _stores[key];
    if (stores != null) {
      for (final store in stores) {
        store.put(key, value);
      }
    }
  }
}
