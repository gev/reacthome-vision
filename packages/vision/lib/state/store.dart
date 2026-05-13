import 'package:vision/state/state_notifier.dart';

abstract interface class Store<K, V, R> {
  R lookup(K key, V value);
  void store(K key, V value);
}

typedef ReactiveStore<K, V> = Store<K, V, StateNotifier<V>>;
