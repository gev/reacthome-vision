import 'package:vision/repository/internal_store.dart';
import 'package:vision/repository/lookup.dart';
import 'package:vision/repository/state_notifier.dart';

typedef Request<K> = void Function(K key);

class LookupRemote<K, V> implements Lookup<K, V> {
  final InternalStore<K, V> _store;
  final Request<K> _request;

  const LookupRemote(this._store, this._request);

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
