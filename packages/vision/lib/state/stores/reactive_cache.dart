import 'package:vision/state/state_notifier.dart';
import 'package:vision/state/store.dart';

class ReactiveCache<K, V> implements ReactiveStore<K, V> {
  final Map<K, StateNotifier<V>> _cache = {};

  @override
  StateNotifier<V> lookup(K key, V defaultValue) {
    var notifier = _cache[key];
    if (notifier == null) {
      notifier = StateNotifier(defaultValue);
      _cache[key] = notifier;
    }
    return notifier;
  }

  @override
  void store(K key, V value) {
    final notifier = _cache[key];
    if (notifier == null) {
      _cache[key] = StateNotifier(value);
    } else {
      notifier.value = value;
    }
  }
}
