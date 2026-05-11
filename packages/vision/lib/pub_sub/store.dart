abstract interface class Store<K, V> {
  V? lookup(K key);
  void store(K key, V value);
}
