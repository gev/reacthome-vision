import 'package:flutter/widgets.dart';
import 'package:vision/stores/lookup.dart';

abstract interface class Store<K, V, R> implements Lookup<K, V, R> {
  void store(K key, V value);
}

typedef ReactiveStore<K, V> = Store<K, V, ValueNotifier<V>>;
