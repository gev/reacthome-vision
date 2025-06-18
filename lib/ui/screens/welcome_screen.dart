import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:studio/core/item.dart';
import 'package:studio/core/scheme.dart';
import 'package:studio/ui/views/scheme_editor.dart';
import 'package:studio/ui_kit/layouts/default_layout.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <Item<int>>[];
    // int id = 0;
    // for (int i = 0; i < 100; i++) {
    //   for (int j = 0; j < 100; j++) {
    //     items.add(Item(id: id++, x: i, y: j));
    //   }
    // }
    items.add(Item(id: 0, x: 0, y: 0));
    return MacosWindow(
      sidebar: Sidebar(
        minWidth: 200,
        maxWidth: 500,
        builder: (_, _) {
          return const Center(child: Text("Catalog"));
        },
      ),
      titleBar: const TitleBar(height: 48),
      child: DefaultLayout(
        body: SchemeEditor(scheme: Scheme(id: 0, items: items)),
      ),
    );
  }
}
