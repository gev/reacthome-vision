import 'dart:ui';

import 'package:scheme/core/item.dart';
import 'package:scheme/core/link.dart';
import 'package:scheme/core/scheme.dart';
import 'package:scheme/stages/anchor_line.dart';

final nodeScheme = const Scheme(
  id: 0,
  items: [Item(id: 0, position: Offset(3, 3))],
  links: [
    Link(
      id: 0,
      source: Connector(id: 0, direction: Direction.left),
      sink: Connector(id: 1, direction: Direction.left),
    ),
  ],
);
