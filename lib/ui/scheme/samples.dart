import 'package:studio/core/item.dart';
import 'package:studio/core/link.dart';
import 'package:studio/core/scheme.dart';
import 'package:studio/ui/stages/anchor_line.dart';

final nodeScheme = Scheme(
  id: 0,
  items: [
    Item(id: 0, x: 3, y: 3, type: ItemType.plus),
    Item(id: 1, x: 5, y: 3, type: ItemType.device),
    Item(id: 2, x: 3, y: 5, type: ItemType.plus),
    Item(id: 3, x: 5, y: 5, type: ItemType.device),
    Item(id: 4, x: 3, y: 7, type: ItemType.plus),
    Item(id: 5, x: 5, y: 7, type: ItemType.device),
    Item(id: 6, x: 3, y: 9, type: ItemType.plus),
    Item(id: 7, x: 5, y: 9, type: ItemType.device),
    Item(id: 8, x: 3, y: 11, type: ItemType.plus),
    Item(id: 9, x: 5, y: 11, type: ItemType.device),
  ],
  links: [
    Link(
      id: 0,
      source: Connector(id: 0, direction: Direction.left),
      sink: Connector(id: 1, direction: Direction.left),
    ),
    Link(
      id: 1,
      source: Connector(id: 2, direction: Direction.left),
      sink: Connector(id: 3, direction: Direction.up),
    ),
    Link(
      id: 2,
      source: Connector(id: 4, direction: Direction.left),
      sink: Connector(id: 5, direction: Direction.right),
    ),
    Link(
      id: 3,
      source: Connector(id: 6, direction: Direction.left),
      sink: Connector(id: 7, direction: Direction.down),
    ),
    Link(
      id: 4,
      source: Connector(id: 8, direction: Direction.left),
      sink: Connector(id: 9, direction: Direction.any),
    ),
  ],
);

final iconicScheme = Scheme(
  id: 1,
  items: [
    Item(id: 0, x: 0, y: 0, type: ItemType.minus),
    Item(id: 1, x: 1, y: 0, type: ItemType.plus),
    Item(id: 2, x: 2, y: 0, type: ItemType.rightArrow),
    Item(id: 3, x: 3, y: 0, type: ItemType.horizontalBar),
    Item(id: 4, x: 4, y: 0, type: ItemType.verticalBar),
    Item(id: 5, x: 0, y: 1, type: ItemType.downMixer),
    Item(id: 6, x: 1, y: 1, type: ItemType.verticalShutter),
    Item(id: 7, x: 2, y: 1, type: ItemType.horizontalShutter),
    Item(id: 8, x: 3, y: 1, type: ItemType.qf),
    Item(id: 9, x: 4, y: 1, type: ItemType.button),
    Item(id: 10, x: 0, y: 2, type: ItemType.rightTriangle),
    Item(id: 11, x: 1, y: 2, type: ItemType.leftTriangle),
    Item(id: 12, x: 2, y: 2, type: ItemType.topTriangle),
    Item(id: 13, x: 3, y: 2, type: ItemType.bottomTriangle),
    Item(id: 14, x: 4, y: 2, type: ItemType.horizontalSP),
    Item(id: 15, x: 0, y: 3, type: ItemType.verticalSP),
    Item(id: 16, x: 1, y: 3, type: ItemType.device),
    Item(id: 17, x: 2, y: 3, type: ItemType.screen),
    Item(id: 18, x: 3, y: 3, type: ItemType.curtains),
    Item(id: 19, x: 4, y: 3, type: ItemType.blinds),
    Item(id: 20, x: 0, y: 4, type: ItemType.leftArrow),
    Item(id: 21, x: 1, y: 4, type: ItemType.topArrow),
    Item(id: 22, x: 2, y: 4, type: ItemType.bottomArrow),
    Item(id: 23, x: 3, y: 4, type: ItemType.heater),
    Item(id: 24, x: 4, y: 4, type: ItemType.airConditioner),
    Item(id: 25, x: 0, y: 5, type: ItemType.projector),
    Item(id: 26, x: 1, y: 5, type: ItemType.rightFilter),
    Item(id: 27, x: 2, y: 5, type: ItemType.leftFilter),
    Item(id: 28, x: 3, y: 5, type: ItemType.downFilter),
    Item(id: 29, x: 4, y: 5, type: ItemType.upFilter),
    Item(id: 30, x: 0, y: 6, type: ItemType.chandelier),
    Item(id: 31, x: 1, y: 6, type: ItemType.bra),
    Item(id: 32, x: 2, y: 6, type: ItemType.track),
    Item(id: 33, x: 3, y: 6, type: ItemType.led),
    Item(id: 34, x: 4, y: 6, type: ItemType.spot),
  ],
);
