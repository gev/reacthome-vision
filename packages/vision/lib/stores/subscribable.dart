import 'package:flutter/widgets.dart';
import 'package:vision/pub_sub/multi_store_subscriber.dart';
import 'package:vision/stores/lookup.dart';
import 'package:vision/stores/store.dart';

class Subscribable<K, V, R> implements Lookup<K, V, R> {
  final MultiStoreSubscriber<K, V> _subscriber;
  final Store<K, V, R> _store;

  const Subscribable({required this._subscriber, required this._store});

  @override
  R lookup(K key, V defaultValue) {
    _subscriber.subscribe(key, _store);
    return _store.lookup(key, defaultValue);
  }
}

typedef ReactiveSubscribable<K, V> = Subscribable<K, V, ValueNotifier<V>>;
