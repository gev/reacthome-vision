abstract interface class Store<K, R, V> {
  R? lookup(K key);
  void store(K key, V value);
}
