abstract class Tracker<K, V> {
  Iterable<K> get keys;
  bool isTracked(K key);
  bool isNotTracked(K key) => !isTracked(key);
  bool get isEmpty => keys.isEmpty;
  bool get isNotEmpty => keys.isNotEmpty;
  void publish(K key, V value);
}

abstract class DynamicTracker<K, V> extends Tracker<K, V> {
  void untrack(K key);
  void untrackAll();
}
