import 'package:studio/core/port.dart';

enum Direction { column, row }

enum ItemType {
  minus,
  plus,
  rightArrow,
  leftArrow,
  topArrow,
  bottomArrow,
  horizontalBar,
  verticalBar,
  mixer,
  verticalShutter,
  horizontalShutter,
  qf,
  button,
  rightTriangle,
  leftTriangle,
  topTriangle,
  bottomTriangle,
  horizontalSP,
  verticalSP,
  device,
  screen,
  curtains,
  blinds,
  heater,
  airConditioner,
  projector,
  rightFilter,
  leftFilter,
  downFilter,
  upFilter,
  chandelier,
  bra,
  track,
  led,
  spot,
  // temperatureSensor,
}

class Item<Id> {
  Item({
    required this.id,
    required this.x,
    required this.y,
    required this.type,
    required this.connectors,
  });
  final Id id;
  final int x;
  final int y;
  final ItemType type;
  final List<PortType> connectors;

  void move(int x, int y) => Item(id: id, x: x, y: y, type: type, connectors: connectors);
}

// class Group<Id> extends Item<Id> {
//   Direction direction;
//   List<Item<Id>> elements;
//   Group({
//     required this.direction,
//     required this.elements,
//     required super.id,
//     required super.x,
//     required super.y,
//   });
// }
