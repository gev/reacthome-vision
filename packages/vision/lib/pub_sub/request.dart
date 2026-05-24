abstract interface class Request<K> {
  void subscribeOne(K key);
  void subscrybeMany(Iterable<K> keys);
}
