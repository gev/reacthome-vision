import 'package:vision/state/state_notifier.dart';
import 'package:vision/store/internal_store.dart';
import 'package:vision/store/lookup.dart';
import 'package:vision/store/put.dart';

class Store<K, V> implements Lookup<K, V>, Put<K, V> {
  late final Lookup<K, V> _lookup;
  late final Put<K, V> _put;

  Store({
    required Lookup<K, V> Function(InternalStore<K, V> store) lookup,
    required Put<K, V> Function(InternalStore<K, V> store) put,
  }) {
    final internalStore = InternalStore<K, V>();
    _lookup = lookup(internalStore);
    _put = put(internalStore);
  }

  @override
  StateNotifier<V> lookup(K key, V defaultValue) {
    return _lookup.lookup(key, defaultValue);
  }

  @override
  void put(K key, V value) {
    _put.put(key, value);
  }
}
