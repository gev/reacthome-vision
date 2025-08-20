import 'port.dart';

class Item<Id> {
  Item({
    required this.id,
    required this.x,
    required this.y,
    this.connectors = const [],
  });
  final Id id;
  final int x;
  final int y;
  final Iterable<PortType> connectors;

  void move(int x, int y) => Item(id: id, x: x, y: y, connectors: connectors);
}
