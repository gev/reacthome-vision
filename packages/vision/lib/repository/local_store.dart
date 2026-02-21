import 'package:vision/repository/internal_store.dart';
import 'package:vision/repository/store.dart';

class LocalStore<K, V> implements Store<K, V> {
  final InternalStore<K, V> _store;

  const LocalStore(this._store);

  @override
  void store(K key, V value) {
    _store.store(key, value);
  }
}
