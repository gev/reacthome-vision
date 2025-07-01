import 'package:flutter/material.dart';
import 'package:studio/core/connector.dart';
import 'package:studio/core/item.dart';
import 'package:studio/core/link.dart';
import 'package:studio/core/scheme.dart';
import 'package:studio/ui/views/scheme_editor.dart';
import 'package:studio/ui_kit/layouts/default_layout.dart';

final connectors = [
  ConnectorType.sensor,
  ConnectorType.actuator,
  ConnectorType.dummy,
];

final scheme = Scheme(
  id: 0,
  items: [
    Item(id: 0, x: 2, y: 3, type: ItemType.minus, connectors: connectors),
    Item(id: 1, x: 4, y: 3, type: ItemType.plus, connectors: connectors),
    Item(id: 2, x: 5, y: 5, type: ItemType.minus, connectors: connectors),
    Item(id: 3, x: 3, y: 5, type: ItemType.plus, connectors: connectors),
  ],
  links: [
    Link(id: 0, source: Vertex(id: 0, idx: 0), sink: Vertex(id: 1, idx: 0)),
    Link(id: 1, source: Vertex(id: 1, idx: 0), sink: Vertex(id: 2, idx: 0)),
    Link(id: 2, source: Vertex(id: 1, idx: 0), sink: Vertex(id: 3, idx: 0)),
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
