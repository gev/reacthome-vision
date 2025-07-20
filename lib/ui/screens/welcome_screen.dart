import 'package:flutter/widgets.dart';
import 'package:studio/core/item.dart';
import 'package:studio/ui/figures/iconic_factory.dart';
import 'package:studio/ui/scheme/samples/node_scheme.dart';
import 'package:studio/ui/views/scheme_editor.dart';
import 'package:studio/ui/widgets/icon.dart' as W;
import 'package:studio/ui_kit/layouts/default_layout.dart';

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
    return DefaultLayout(
      body: Row(
        children: [
          Expanded(child: SchemeEditor(scheme: nodeScheme)),
          SizedBox(
            width: 288,
            child: Column(
              children: [
                Wrap(
                  children: [
                    for (final it in ItemType.values)
                      Draggable(
                        data: it,
                        dragAnchorStrategy: childDragAnchorStrategy,
                        feedback: Padding(
                          padding: const EdgeInsetsGeometry.all(16),
                          child: W.Icon(
                            iconic: selectIconic(it, const Offset(20, 20), 40),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsGeometry.all(16),
                          child: W.Icon(
                            iconic: selectIconic(it, const Offset(20, 20), 40),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
