import 'package:flutter/widgets.dart';
import 'package:vision/stores/lookup.dart';
import 'package:vision/stores/put.dart';

abstract interface class Store<K, V, R> implements Lookup<K, V, R>, Put<K, V> {}

typedef ReactiveStore<K, V> = Store<K, V, ValueNotifier<V>>;
