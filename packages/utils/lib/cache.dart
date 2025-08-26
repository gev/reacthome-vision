abstract class Cache<K, V> {
  final _values = <K, V>{};

  V make(K key);

  V lookup(K key) {
    final value = _values[key];
    if (value == null) {
      final v = make(key);
      _values[key] = v;
      return v;
    }
    return value;
  }

  void remove(K key) {
    _values.remove(key);
  }

  void clear() {
    _values.clear();
  }
}
