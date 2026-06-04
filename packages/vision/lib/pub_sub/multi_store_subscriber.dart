import 'package:vision/pub_sub/request.dart';
import 'package:vision/pub_sub/subscriber.dart';
import 'package:vision/stores/put.dart';

class MultiStoreSubscriber<K, V> extends Subscriber<K, V> {
  final Map<K, Set<Put<K, V>>> _stores = {};
  final SubscribeRequest<K> _subscribe;

  MultiStoreSubscriber({required this._subscribe});

  void subscribe(K key, Put<K, V> store) {
    var stores = _stores[key];
    if (stores == null) {
      _stores[key] = {store};
      _subscribe.subscribeOne(key);
    } else {
      stores.add(store);
    }
  }

  @override
  bool get isEmpty => _stores.isEmpty;

  @override
  bool isSubscribed(K key) => _stores.containsKey(key);

  @override
  void publish(K key, V value) {
    final stores = _stores[key];
    if (stores != null) {
      for (final store in stores) {
        store.put(key, value);
      }
    }
  }

  @override
  void reSubscribeAll() {
    if (isNotEmpty) {
      _subscribe.subscribeMany(_stores.keys);
    }
  }
}

class DynamicMultiStoreSubscriber<K, V> extends MultiStoreSubscriber<K, V>
    implements DynamicSubscriber<K, V> {
  final UnsubscribeRequest<K> _unsubscribe;

  DynamicMultiStoreSubscriber({
    required super.subscribe,
    required this._unsubscribe,
  });

  @override
  void unsubscribe(K key) {
    if (isSubscribed(key)) {
      _unsubscribe.unsubscribeOne(key);
      _stores.remove(key);
    }
  }

  @override
  void unsubscribeAll() {
    if (isNotEmpty) {
      _unsubscribe.unsubscribeMany(_stores.keys);
      _stores.clear();
    }
  }
}
