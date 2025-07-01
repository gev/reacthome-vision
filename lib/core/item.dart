enum Direction { column, row }

enum ItemType {
  minus,
  plus,
  arrow,
  horizontalBar,
  verticalBar,
  mixer,
  shutter,
  horizontalShutter,
  qf,
  button,
  rightTriangle,
  leftTriangle,
  topTriangle,
  bottomTriangle,
  sp,
  verticalSp,
  device,
  screen,
  curtains,
  blinds,
  // tp,
  // filter,
  // sHeater,
  // chandelier,
  // bra,
  // spot,
  // led,
  // track,
  // temperatureSensor,
  // airConditioner,
  // projector,
}

class Item<Id> {
  Item({
    required this.id,
    required this.x,
    required this.y,
    required this.type,
  });
  final Id id;
  final int x;
  final int y;
  final ItemType type;

  void move(int x, int y) => Item(id: id, x: x, y: y, type: type);
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
