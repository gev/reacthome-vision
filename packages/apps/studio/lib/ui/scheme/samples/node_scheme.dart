import 'package:scheme/core/item.dart';
import 'package:scheme/core/link.dart';
import 'package:scheme/core/scheme.dart';
import 'package:scheme/stages/anchor_line.dart';

final nodeScheme = Scheme(
  id: 0,
  items: [
    Item(id: 0, x: 3, y: 3),
    Item(id: 1, x: 5, y: 3),
    Item(id: 2, x: 3, y: 5),
    Item(id: 3, x: 5, y: 5),
    Item(id: 4, x: 3, y: 7),
    Item(id: 5, x: 5, y: 7),
    Item(id: 6, x: 3, y: 9),
    Item(id: 7, x: 5, y: 9),
    Item(id: 8, x: 3, y: 11),
    Item(id: 9, x: 5, y: 11),

    Item(id: 10, x: 9, y: 3),
    Item(id: 11, x: 11, y: 3),
    Item(id: 12, x: 9, y: 5),
    Item(id: 13, x: 11, y: 5),
    Item(id: 14, x: 9, y: 7),
    Item(id: 15, x: 11, y: 7),
    Item(id: 16, x: 9, y: 9),
    Item(id: 17, x: 11, y: 9),
    Item(id: 18, x: 9, y: 11),
    Item(id: 19, x: 11, y: 11),

    Item(id: 20, x: 15, y: 3),
    Item(id: 21, x: 17, y: 3),
    Item(id: 22, x: 15, y: 5),
    Item(id: 23, x: 17, y: 5),
    Item(id: 24, x: 15, y: 7),
    Item(id: 25, x: 17, y: 7),
    Item(id: 26, x: 15, y: 9),
    Item(id: 27, x: 17, y: 9),
    Item(id: 28, x: 15, y: 11),
    Item(id: 29, x: 17, y: 11),

    Item(id: 30, x: 21, y: 3),
    Item(id: 31, x: 23, y: 3),
    Item(id: 32, x: 21, y: 5),
    Item(id: 33, x: 23, y: 5),
    Item(id: 34, x: 21, y: 7),
    Item(id: 35, x: 23, y: 7),
    Item(id: 36, x: 21, y: 9),
    Item(id: 37, x: 23, y: 9),
    Item(id: 38, x: 21, y: 11),
    Item(id: 39, x: 23, y: 11),

    Item(id: 40, x: 27, y: 3),
    Item(id: 41, x: 29, y: 3),
    Item(id: 42, x: 27, y: 5),
    Item(id: 43, x: 29, y: 5),
    Item(id: 44, x: 27, y: 7),
    Item(id: 45, x: 29, y: 7),
    Item(id: 46, x: 27, y: 9),
    Item(id: 47, x: 29, y: 9),
    Item(id: 48, x: 27, y: 11),
    Item(id: 49, x: 29, y: 11),
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
      sink: Connector(id: 9, direction: Direction.auto),
    ),

    Link(
      id: 5,
      source: Connector(id: 10, direction: Direction.up),
      sink: Connector(id: 11, direction: Direction.left),
    ),
    Link(
      id: 6,
      source: Connector(id: 12, direction: Direction.up),
      sink: Connector(id: 13, direction: Direction.up),
    ),
    Link(
      id: 7,
      source: Connector(id: 14, direction: Direction.up),
      sink: Connector(id: 15, direction: Direction.right),
    ),
    Link(
      id: 8,
      source: Connector(id: 16, direction: Direction.up),
      sink: Connector(id: 17, direction: Direction.down),
    ),
    Link(
      id: 9,
      source: Connector(id: 18, direction: Direction.up),
      sink: Connector(id: 19, direction: Direction.auto),
    ),

    Link(
      id: 10,
      source: Connector(id: 20, direction: Direction.right),
      sink: Connector(id: 21, direction: Direction.left),
    ),
    Link(
      id: 11,
      source: Connector(id: 22, direction: Direction.right),
      sink: Connector(id: 23, direction: Direction.up),
    ),
    Link(
      id: 12,
      source: Connector(id: 24, direction: Direction.right),
      sink: Connector(id: 25, direction: Direction.right),
    ),
    Link(
      id: 13,
      source: Connector(id: 26, direction: Direction.right),
      sink: Connector(id: 27, direction: Direction.down),
    ),
    Link(
      id: 14,
      source: Connector(id: 28, direction: Direction.right),
      sink: Connector(id: 29, direction: Direction.auto),
    ),

    Link(
      id: 15,
      source: Connector(id: 30, direction: Direction.down),
      sink: Connector(id: 31, direction: Direction.left),
    ),
    Link(
      id: 16,
      source: Connector(id: 32, direction: Direction.down),
      sink: Connector(id: 33, direction: Direction.up),
    ),
    Link(
      id: 17,
      source: Connector(id: 34, direction: Direction.down),
      sink: Connector(id: 35, direction: Direction.right),
    ),
    Link(
      id: 18,
      source: Connector(id: 36, direction: Direction.down),
      sink: Connector(id: 37, direction: Direction.down),
    ),
    Link(
      id: 19,
      source: Connector(id: 38, direction: Direction.down),
      sink: Connector(id: 39, direction: Direction.auto),
    ),

    Link(
      id: 20,
      source: Connector(id: 40, direction: Direction.auto),
      sink: Connector(id: 41, direction: Direction.left),
    ),
    Link(
      id: 21,
      source: Connector(id: 42, direction: Direction.auto),
      sink: Connector(id: 43, direction: Direction.up),
    ),
    Link(
      id: 22,
      source: Connector(id: 44, direction: Direction.auto),
      sink: Connector(id: 45, direction: Direction.right),
    ),
    Link(
      id: 23,
      source: Connector(id: 46, direction: Direction.auto),
      sink: Connector(id: 47, direction: Direction.down),
    ),
    Link(
      id: 24,
      source: Connector(id: 48, direction: Direction.auto),
      sink: Connector(id: 49, direction: Direction.auto),
    ),
  ],
);
