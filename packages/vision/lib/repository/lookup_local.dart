import 'package:vision/repository/internal_store.dart';
import 'package:vision/repository/lookup.dart';
import 'package:vision/repository/state_notifier.dart';

class LookupLocal<K, V> implements Lookup<K, V> {
  final InternalStore<K, V> _store;

  const LookupLocal(this._store);

  @override
  StateNotifier<V> lookup(K key, V defaultValue) {
    return _store.lookup(key) ?? StateNotifier(defaultValue);
  }
}
