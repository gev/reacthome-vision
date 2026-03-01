import 'package:vision/store/internal_store.dart';
import 'package:vision/store/put.dart';

class MemoryPut<K, V> implements Put<K, V> {
  final InternalStore<K, V> _store;

  MemoryPut(this._store);

  @override
  void put(K key, V value) {
    _store.put(key, value);
  }
}
