import 'package:vision/pub_sub/subscriber.dart';
import 'package:vision/stores/store.dart';

class SubscribableStore<K, V, R> implements Store<K, V, R> {
  final Subscriber<K> _subscriber;
  final Store<K, V, R> _store;

  const SubscribableStore({required this._subscriber, required this._store});

  @override
  R lookup(K key, V defaultValue) {
    _subscriber.subscribe(key);
    return _store.lookup(key, defaultValue);
  }

  @override
  void store(K key, V value) {
    _subscriber.publish(key, value, _store);
  }
}
