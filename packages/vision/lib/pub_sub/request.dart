abstract interface class Request<K> {
  void one(K key);
  void many(Iterable<K> keys);
}
