class Pool<T> {
  final Set<T> _items = {};

  void add(T item) {
    _items.add(item);
  }

  Iterable<T> get all => _items;
}
