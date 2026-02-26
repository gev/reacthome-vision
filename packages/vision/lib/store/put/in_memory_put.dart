import 'package:vision/store/internal.dart';
import 'package:vision/store/put.dart';

class InMemoryPut<K, V> implements Put<K, V> {
  final Internal<K, V> _store;

  InMemoryPut(this._store);

  @override
  void put(K key, V value) {
    _store.put(key, value);
  }
}
