import 'package:vision/pub_sub/subscriber.dart';
import 'package:vision/stores/store.dart';

class SubscribableStore<K, V, R> implements Store<K, V, R> {
  final Subscriber<K, V, R> _subscriber;

  SubscribableStore(this._subscriber);

  @override
  R lookup(K key, V value) => _subscriber.subscribe(key, value);

  @override
  void store(K key, V value) => _subscriber.publish(key, value);
}
