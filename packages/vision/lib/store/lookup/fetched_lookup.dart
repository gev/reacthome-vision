import 'package:vision/store/internal_store.dart';
import 'package:vision/store/lookup.dart';
import 'package:vision/store/state_notifier.dart';

typedef Fetch<K> = void Function(K key);

class FetchedLookup<K, V> implements Lookup<K, V> {
  final InternalStore<K, V> _store;
  final Fetch<K> _request;

  const FetchedLookup(this._store, this._request);

  @override
  StateNotifier<V> lookup(K key, V defaultValue) {
    var state = _store.lookup(key);
    if (state == null) {
      _request(key);
      state = StateNotifier(defaultValue);
    }
    return state;
  }
}
