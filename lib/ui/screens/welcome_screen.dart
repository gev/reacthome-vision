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
        body: SchemeEditor(
          scheme: Scheme(
            id: 0,
            items: [Item(id: 0, x: 2, y: 3), Item(id: 1, x: 4, y: 3)],
          ),
        ),
      ),
    );
  }
}
