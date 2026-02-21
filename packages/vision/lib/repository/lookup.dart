import 'package:vision/repository/state_notifier.dart';

abstract interface class Lookup<K, V> {
  StateNotifier<V> lookup(K key, V defaultValue);
}
