enum Direction { column, row }

class Item<Id> {
  Item({required this.id, required this.x, required this.y});
  final Id id;
  final int x;
  final int y;

  void move(int x, int y) => Item(id: id, x: x, y: y);
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
