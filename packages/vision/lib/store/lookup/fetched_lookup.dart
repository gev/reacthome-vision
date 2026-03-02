import 'package:vision/state/state_notifier.dart';
import 'package:vision/store/internal_store.dart';
import 'package:vision/store/lookup.dart';

typedef Fetch<K> = void Function(K key);

class FetchedLookup<K, V> implements Lookup<K, V> {
  final InternalStore<K, V> _store;
  final Fetch<K> _request;

  const FetchedLookup(this._store, this._request);

  @override
  StateNotifier<V> lookup(K key, V defaultValue) {
    return _store.lookup(key, () {
      _request(key);
      return defaultValue;
    });
  }
}
