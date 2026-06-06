import 'package:vision/pub_sub/request.dart';
import 'package:vision/pub_sub/subscriber.dart';
import 'package:vision/stores/put.dart';

class SingleStoreSubscriber<K, V> extends Subscriber<K, V> {
  final Set<K> _keys = {};
  final Put<K, V> _store;
  final SubscribeRequest<K> _subscribe;

  SingleStoreSubscriber({required this._store, required this._subscribe});

  void subscribe(K key) {
    if (isUnsubscribed(key)) {
      _keys.add(key);
      _subscribe.subscribeOne(key);
    }
  }

  @override
  bool get isEmpty => _keys.isEmpty;

  @override
  bool isSubscribed(K key) => _keys.contains(key);

  @override
  void publish(K key, V value) {
    if (isSubscribed(key)) {
      _store.put(key, value);
    }
  }

  @override
  void resubscribeAll() {
    if (isNotEmpty) {
      _subscribe.subscribeMany(_keys);
    }
  }
}

class DynamicSingleStoreSubscriber<K, V> extends SingleStoreSubscriber<K, V>
    implements DynamicSubscriber<K, V> {
  final UnsubscribeRequest<K> _unsubscribe;

  DynamicSingleStoreSubscriber({
    required super.store,
    required super.subscribe,
    required this._unsubscribe,
  });

  @override
  void unsubscribe(K key) {
    if (isSubscribed(key)) {
      _unsubscribe.unsubscribeOne(key);
      _keys.remove(key);
    }
  }

  @override
  void unsubscribeAll() {
    if (isNotEmpty) {
      _unsubscribe.unsubscribeMany(_keys);
      _keys.clear();
    }
  }
}
