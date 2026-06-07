abstract interface class Request<K> {
  void subscribeOne(K key);
  void subscribeMany(Iterable<K> keys);
  void unsubscribeOne(K key);
  void unsubscribeMany(Iterable<K> keys);
}
