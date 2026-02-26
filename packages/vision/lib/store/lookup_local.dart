import 'package:vision/store/internal.dart';
import 'package:vision/store/lookup.dart';
import 'package:vision/store/state_notifier.dart';

class LookupLocal<K, V> implements Lookup<K, V> {
  final Internal<K, V> _store;

  const LookupLocal(this._store);

  @override
  StateNotifier<V> lookup(K key, V defaultValue) {
    return _store.lookup(key) ?? StateNotifier(defaultValue);
  }
}
