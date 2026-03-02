import 'package:vision/state/state_notifier.dart';

class InternalStore<K, V> {
  final _store = <K, StateNotifier<V>>{};

  void put(K key, V value) {
    final state = _store[key];
    if (state != null) {
      state.value = value;
    }
  }

  StateNotifier<V> lookup(K key, V Function() getDefaultValue) {
    var state = _store[key];
    if (state == null) {
      final value = getDefaultValue();
      state = StateNotifier(value);
      _store[key] = state;
    }
    return state;
  }

  void clear() => _store.clear();
}
