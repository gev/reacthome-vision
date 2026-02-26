import 'package:vision/store/internal_store.dart';
import 'package:vision/store/put.dart';

class InMemoryPut<K, V> implements Put<K, V> {
  final InternalStore<K, V> _store;

  InMemoryPut(this._store);

  @override
  void put(K key, V value) {
    _store.put(key, value);
  }
}
