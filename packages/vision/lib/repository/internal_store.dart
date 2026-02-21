import 'package:vision/repository/state_notifier.dart';

class InternalStore<K, V> {
  final _store = <K, StateNotifier<V>>{};

  void store(K key, V value) {
    final state = _store[key];
    if (state != null) {
      state.value = value;
    }
    _store[key] = StateNotifier(value);
  }

  StateNotifier<V>? lookup(K key) => _store[key];
}
