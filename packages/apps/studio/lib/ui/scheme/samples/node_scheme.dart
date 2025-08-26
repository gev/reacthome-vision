import 'dart:ui';

import 'package:scheme/core/item.dart';
import 'package:scheme/core/link.dart';
import 'package:scheme/core/scheme.dart';
import 'package:scheme/stages/anchor_line.dart';

final nodeScheme = Scheme(
  id: 0,
  items: const [
    Item(id: 0, offset: Offset(3, 3)),
    Item(id: 1, offset: Offset(5, 3)),
  ],
  links: const [
    Link(
      id: 0,
      source: Connector(id: 0, direction: Direction.left),
      sink: Connector(id: 1, direction: Direction.left),
    ),
  ],
);
