typedef Predicate<K, V> = ({K key, V? version});
typedef Specification<K, V> = Iterable<Predicate<K, V>>;

abstract interface class Request<K, V> {
  void one(Predicate<K, V> pred);
  void many(Specification<K, V> spec);
}
