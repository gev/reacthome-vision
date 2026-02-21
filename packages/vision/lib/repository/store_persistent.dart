import 'package:vision/repository/internal_store.dart';
import 'package:vision/repository/store.dart';

typedef Persist<K, V> = void Function(K key, V value);

class RemoteStore<K, V> implements Store<K, V> {
  final InternalStore<K, V> _store;
  final Persist<K, V> _persist;

  RemoteStore(this._store, this._persist);

  @override
  void store(K key, V value) {
    _store.store(key, value);
    _persist(key, value);
  }
}
