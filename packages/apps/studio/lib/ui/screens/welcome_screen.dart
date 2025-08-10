import 'package:flutter/widgets.dart';
import 'package:studio/ui/scheme/samples/node_scheme.dart';
import 'package:studio/ui/views/palette.dart';
import 'package:studio/ui/views/scheme_editor.dart';
import 'package:ui_kit/layouts/desktop.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Desktop(
      endSidebar: const Palette(),
      body: SchemeEditor(scheme: nodeScheme),
    );
  }
}
