import 'package:vision/store/internal.dart';
import 'package:vision/store/put.dart';

typedef Persist<K, V> = void Function(K key, V value);

class PersistentPut<K, V> implements Put<K, V> {
  final Internal<K, V> _store;
  final Persist<K, V> _persist;

  PersistentPut(this._store, this._persist);

  @override
  void put(K key, V value) {
    _store.put(key, value);
    _persist(key, value);
  }
}
