abstract class Subscriber<K, V> {
  bool get isEmpty;
  bool get isNotEmpty => !isEmpty;
  bool isSubscribed(K key);
  bool isUnsubscribed(K key) => !isSubscribed(key);
  void reSubscribeAll();
  void publish(K key, V value);
}

abstract interface class DynamicSubscriber<K, V> {
  void unsubscribe(K key);
  void unsubscribeAll();
}
