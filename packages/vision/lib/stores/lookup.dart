import 'package:flutter/widgets.dart';

abstract interface class Lookup<K, V, R> {
  R lookup(K key, V defaultValue);
}

typedef ReactiveLookup<K, V> = Lookup<K, V, ValueNotifier<V>>;
