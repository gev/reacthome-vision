import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scheme/core/item.dart';
import 'package:studio/ui/widgets/scheme_icon.dart';

class Palette extends StatelessWidget {
  const Palette({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        children: [
          for (final it in ItemType.values)
            Draggable(
              key: ValueKey(it),
              data: it,
              dragAnchorStrategy: (_, _, _) => const Offset(60, 60),
              feedback: Padding(
                padding: const EdgeInsetsGeometry.all(16),
                child: SchemeIcon(type: it, size: 80),
              ),
              child: Padding(
                padding: const EdgeInsetsGeometry.all(16),
                child: SchemeIcon(type: it, size: 40),
              ),
            ),
        ],
      ),
    );
  }
}
