import 'package:flutter/widgets.dart';
import 'package:vision/stores/store.dart';

class ReactiveCache<K, V> implements ReactiveStore<K, V> {
  final Map<K, ValueNotifier<V>> _cache = {};

  @override
  ValueNotifier<V> lookup(K key, V defaultValue) {
    var notifier = _cache[key];
    if (notifier == null) {
      notifier = ValueNotifier(defaultValue);
      _cache[key] = notifier;
    }
    return notifier;
  }

  @override
  void store(K key, V value) {
    final notifier = _cache[key];
    if (notifier != null) {
      notifier.value = value;
    }
  }
}
