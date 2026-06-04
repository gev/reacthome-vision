import 'package:vision/pub_sub/tracker.dart';
import 'package:vision/stores/put.dart';

class MultiTracker<K, V> extends Tracker<K, V> {
  final Map<K, Set<Put<K, V>>> _stores = {};

  void track(K key, Put<K, V> store) {
    var stores = _stores[key];
    if (stores != null) {
      stores.add(store);
    } else {
      _stores[key] = {store};
    }
  }

  @override
  bool isTracked(K key) => _stores.containsKey(key);

  @override
  Iterable<K> get keys => _stores.keys;

  @override
  void publish(K key, V value) {
    final stores = _stores[key];
    if (stores != null) {
      for (final store in stores) {
        store.put(key, value);
      }
    }
  }
}
