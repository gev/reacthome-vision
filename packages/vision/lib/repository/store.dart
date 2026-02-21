abstract interface class Store<K, V> {
  void store(K key, V value);
}
