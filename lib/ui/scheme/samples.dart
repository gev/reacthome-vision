import 'package:studio/core/item.dart';
import 'package:studio/core/link.dart';
import 'package:studio/core/port.dart';
import 'package:studio/core/scheme.dart';

final connectors = [PortType.sensor, PortType.actuator, PortType.dummy];

final nodeScheme = Scheme(
  id: 0,
  items: [
    Item(id: 0, x: 3, y: 3, type: ItemType.plus, connectors: connectors),
    Item(id: 1, x: 7, y: 3, type: ItemType.device, connectors: connectors),
    Item(id: 2, x: 3, y: 5, type: ItemType.plus, connectors: connectors),
    Item(id: 3, x: 7, y: 5, type: ItemType.device, connectors: connectors),
    Item(id: 4, x: 3, y: 7, type: ItemType.plus, connectors: connectors),
    Item(id: 5, x: 7, y: 7, type: ItemType.device, connectors: connectors),
  ],
  links: [
    Link(id: 0, source: Connector(id: 0, idx: 0), sink: Connector(id: 1, idx: 0)),
    Link(id: 1, source: Connector(id: 2, idx: 0), sink: Connector(id: 3, idx: 0)),
    Link(id: 2, source: Connector(id: 4, idx: 0), sink: Connector(id: 5, idx: 0)),
  ],
);

final iconicScheme = Scheme(
  id: 0,
  items: [
    Item(id: 0, x: 0, y: 0, type: ItemType.minus, connectors: connectors),
    Item(id: 1, x: 1, y: 0, type: ItemType.plus, connectors: connectors),
    Item(id: 2, x: 2, y: 0, type: ItemType.rightArrow, connectors: connectors),
    Item(id: 3, x: 3, y: 0, type: ItemType.horizontalBar, connectors: connectors),
    Item(id: 4, x: 4, y: 0, type: ItemType.verticalBar, connectors: connectors),
    Item(id: 5, x: 0, y: 1, type: ItemType.mixer, connectors: connectors),
    Item(id: 6, x: 1, y: 1, type: ItemType.verticalShutter, connectors: connectors),
    Item(id: 7, x: 2, y: 1, type: ItemType.horizontalShutter, connectors: connectors),
    Item(id: 8, x: 3, y: 1, type: ItemType.qf, connectors: connectors),
    Item(id: 9, x: 4, y: 1, type: ItemType.button, connectors: connectors),
    Item(id: 10, x: 0, y: 2, type: ItemType.rightTriangle, connectors: connectors),
    Item(id: 11, x: 1, y: 2, type: ItemType.leftTriangle, connectors: connectors),
    Item(id: 12, x: 2, y: 2, type: ItemType.topTriangle, connectors: connectors),
    Item(id: 13, x: 3, y: 2, type: ItemType.bottomTriangle, connectors: connectors),
    Item(id: 14, x: 4, y: 2, type: ItemType.horizontalSP, connectors: connectors),
    Item(id: 15, x: 0, y: 3, type: ItemType.verticalSP, connectors: connectors),
    Item(id: 16, x: 1, y: 3, type: ItemType.device, connectors: connectors),
    Item(id: 17, x: 2, y: 3, type: ItemType.screen, connectors: connectors),
    Item(id: 18, x: 3, y: 3, type: ItemType.curtains, connectors: connectors),
    Item(id: 19, x: 4, y: 3, type: ItemType.blinds, connectors: connectors),
    Item(id: 20, x: 0, y: 4, type: ItemType.leftArrow, connectors: connectors),
    Item(id: 21, x: 1, y: 4, type: ItemType.topArrow, connectors: connectors),
    Item(id: 22, x: 2, y: 4, type: ItemType.bottomArrow, connectors: connectors),
    Item(id: 23, x: 3, y: 4, type: ItemType.heater, connectors: connectors),
  ],
);
