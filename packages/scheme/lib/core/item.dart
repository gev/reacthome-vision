import 'dart:ui';

enum ItemType { dummy }

class Item<Id> {
  const Item({
    required this.id,
    required this.position,
    // this.connectors = const [],
  });
  final Id id;
  final Offset position;
  // final Iterable<PortType> connectors;

  // void move(int x, int y) => Item(id: id, x: x, y: y, connectors: connectors);
}
