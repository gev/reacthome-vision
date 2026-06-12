abstract interface class Version<K, V> {
  V? version(K key);
}
