abstract interface class SubscribeRequest<K> {
  void subscribeOne(K key);
  void subscribeMany(Iterable<K> keys);
}

abstract interface class UnsubscribeRequest<K> {
  void unsubscribeOne(K key);
  void unsubscribeMany(Iterable<K> keys);
}
