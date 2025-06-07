enum Direction { column, row }

class Item<Id> {
  final Id id;
  double x;
  double y;
  Item({required this.id, required this.x, required this.y});
}

class Group<Id> extends Item<Id> {
  Direction direction;
  List<Item<Id>> elements;
  Group({
    required this.direction,
    required this.elements,
    required super.id,
    required super.x,
    required super.y,
  });
}

typedef Items<Id> = Iterable<Item<Id>>;
