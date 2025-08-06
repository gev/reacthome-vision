import 'package:flutter/widgets.dart';
import 'package:scheme/core/item.dart';
import 'package:scheme/stages/iconic_factory.dart';
import 'package:studio/ui/scheme/samples/node_scheme.dart';
import 'package:studio/ui/views/scheme_editor.dart';
import 'package:studio/ui/widgets/icon.dart' as w;
import 'package:ui_kit/widgets.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return UI.AppDesktop(
      end: Column(
        children: [
          Wrap(
            children: [
              for (final it in ItemType.values)
                Draggable(
                  data: it,
                  dragAnchorStrategy: (_, _, _) => const Offset(60, 60),
                  feedback: Padding(
                    padding: const EdgeInsetsGeometry.all(16),
                    child: w.Icon(
                      iconic: selectIconic(it, const Offset(40, 40), 80),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsetsGeometry.all(16),
                    child: w.Icon(
                      iconic: selectIconic(it, const Offset(20, 20), 40),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Expanded(child: SchemeEditor(scheme: nodeScheme)),
    );
  }
}
