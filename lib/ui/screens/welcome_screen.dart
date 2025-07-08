import 'package:flutter/material.dart';
import 'package:studio/core/item.dart';
import 'package:studio/core/port.dart';
import 'package:studio/core/scheme.dart';
import 'package:studio/ui/views/scheme_editor.dart';
import 'package:studio/ui_kit/layouts/default_layout.dart';

final connectors = [PortType.sensor, PortType.actuator, PortType.dummy];

final scheme = Scheme(
  id: 0,
  items: [
    Item(id: 0, x: 0, y: 0, type: ItemType.minus, connectors: connectors),
    Item(id: 1, x: 1, y: 0, type: ItemType.plus, connectors: connectors),
    Item(id: 2, x: 2, y: 0, type: ItemType.rightArrow, connectors: connectors),
    Item(id: 3, x: 3, y: 0, type: ItemType.horizontalBar, connectors: connectors),
    Item(id: 4, x: 4, y: 0, type: ItemType.verticalBar, connectors: connectors),
    Item(id: 5, x: 0, y: 1, type: ItemType.rightMixer, connectors: connectors),
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
    Item(id: 24, x: 4, y: 4, type: ItemType.airConditioner, connectors: connectors),
    Item(id: 25, x: 0, y: 5, type: ItemType.projector, connectors: connectors),
    Item(id: 26, x: 1, y: 5, type: ItemType.rightFilter, connectors: connectors),
    Item(id: 27, x: 2, y: 5, type: ItemType.leftFilter, connectors: connectors),
    Item(id: 28, x: 3, y: 5, type: ItemType.downFilter, connectors: connectors),
    Item(id: 29, x: 4, y: 5, type: ItemType.upFilter, connectors: connectors),
    Item(id: 30, x: 0, y: 6, type: ItemType.chandelier, connectors: connectors),
    Item(id: 31, x: 1, y: 6, type: ItemType.bra, connectors: connectors),
    Item(id: 32, x: 2, y: 6, type: ItemType.track, connectors: connectors),
    Item(id: 33, x: 3, y: 6, type: ItemType.led, connectors: connectors),
    Item(id: 34, x: 4, y: 6, type: ItemType.spot, connectors: connectors),
    Item(id: 35, x: 0, y: 7, type: ItemType.upMixer, connectors: connectors),
    Item(id: 36, x: 1, y: 7, type: ItemType.rightMixer, connectors: connectors),
    Item(id: 37, x: 2, y: 7, type: ItemType.leftMixer, connectors: connectors),
    Item(id: 38, x: 3, y: 7, type: ItemType.delay, connectors: connectors),
    Item(id: 39, x: 4, y: 7, type: ItemType.temperatureSensor, connectors: connectors),
  ],
  links: [
    // Link(id: 0, source: Connector(id: 0, idx: 0), sink: Connector(id: 1, idx: 0)),
    // Link(id: 1, source: Connector(id: 2, idx: 0), sink: Connector(id: 3, idx: 0)),
    // Link(id: 2, source: Connector(id: 4, idx: 0), sink: Connector(id: 5, idx: 0)),
    // Link(id: 1, source: Vertex(id: 1, idx: 0), sink: Vertex(id: 2, idx: 0)),
    // Link(id: 2, source: Vertex(id: 1, idx: 0), sink: Vertex(id: 3, idx: 0)),
  ],
);

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // return MacosWindow(
    //   sidebar: Sidebar(
    //     minWidth: 200,
    //     maxWidth: 500,
    //     builder: (_, _) {
    //       return const Center(child: Text("Catalog"));
    //     },
    //   ),
    //   titleBar: const TitleBar(height: 48),
    //   child: DefaultLayout(
    //     body: SchemeEditor(
    //       scheme: Scheme(
    //         id: 0,
    //         items: [
    //           Item(id: 0, x: 2, y: 3),
    //           Item(id: 1, x: 4, y: 3),
    //           Item(id: 2, x: 5, y: 5),
    //           Item(id: 3, x: 3, y: 5),
    //         ],
    //         links: [
    //           Link(id: 0, source: 0, sink: 1),
    //           Link(id: 1, source: 1, sink: 2),
    //           Link(id: 2, source: 1, sink: 3),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
    return DefaultLayout(body: SchemeEditor(scheme: scheme));
  }
}
