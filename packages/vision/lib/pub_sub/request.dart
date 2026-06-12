typedef Predicate<K, V> = ({K key, V? version});
typedef Specification<K, V> = Iterable<Predicate<K, V>>;

abstract interface class Request<K, V> {
  void subscribeOne(Predicate<K, V> pred);
  void subscribeMany(Specification<K, V> spec);
}
