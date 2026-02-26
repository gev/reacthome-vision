import 'package:vision/store/internal.dart';
import 'package:vision/store/put.dart';

class PutInMemory<K, V> implements Put<K, V> {
  final Internal<K, V> _store;

  PutInMemory(this._store);

  @override
  void put(K key, V value) {
    _store.put(key, value);
  }
}
