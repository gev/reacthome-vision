import 'package:flutter/widgets.dart';
import 'package:vision/stores/lookup.dart';
import 'package:vision/stores/put.dart';
import 'package:vision/stores/reactive_entry.dart';
import 'package:vision/stores/revision.dart';
import 'package:vision/stores/version.dart';

class ReactiveCache<K, P, V>
    implements ReactiveLookup<K, P>, Version<K, V>, Put<K, Revision<P, V>> {
  final Map<K, ReactiveEntry<P, V>> _cache = {};

  @override
  ValueNotifier<P> lookup(K key, P defaultValue) {
    var entry = _cache[key];
    if (entry == null) {
      entry = ReactiveEntry(defaultValue);
      _cache[key] = entry;
    }
    return entry.notifier;
  }

  @override
  V? version(K key) => _cache[key]?.version;

  @override
  void put(K key, Revision<P, V> value) {
    final entry = _cache[key];
    if (entry != null) {
      entry.value = value;
    }
  }
}
