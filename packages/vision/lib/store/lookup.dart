import 'package:flutter/widgets.dart';

abstract interface class Lookup<K, T, R> {
  R lookup(K key, T defaultValue);
}

typedef ReactiveLookup<K, T> = Lookup<K, T, ValueNotifier<T>>;
