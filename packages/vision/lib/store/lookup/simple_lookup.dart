import 'package:vision/store/internal_store.dart';
import 'package:vision/store/lookup.dart';
import 'package:vision/store/state_notifier.dart';

class SimpleLookup<K, V> implements Lookup<K, V> {
  final InternalStore<K, V> _store;

  const SimpleLookup(this._store);

  @override
  StateNotifier<V> lookup(K key, V defaultValue) {
    return _store.lookup(key) ?? StateNotifier(defaultValue);
  }
}
