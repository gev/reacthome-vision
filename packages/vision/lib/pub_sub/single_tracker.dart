import 'package:vision/pub_sub/tracker.dart';
import 'package:vision/stores/put.dart';

class SingleTracker<K, V> extends Tracker<K, V> {
  final Set<K> _keys = {};
  final Put<K, V> _store;

  SingleTracker(this._store);

  void track(K key) {
    _keys.add(key);
  }

  @override
  bool isTracked(K key) => _keys.contains(key);

  @override
  Iterable<K> get keys => _keys;

  @override
  void publish(K key, V value) {
    if (_keys.contains(key)) {
      _store.put(key, value);
    }
  }
}
