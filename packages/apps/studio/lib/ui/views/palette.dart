import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconic/iconics.dart';
import 'package:iconic/widgets/scheme_icon.dart';

class Palette extends StatelessWidget {
  const Palette({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        children: [
          for (final it in iconics)
            Draggable(
              key: ValueKey(it),
              data: it,
              dragAnchorStrategy: (_, _, _) => const Offset(60, 60),
              feedback: Padding(
                padding: const EdgeInsetsGeometry.all(16),
                child: SchemeIcon(makeIconic: it, size: 80),
              ),
              child: Padding(
                padding: const EdgeInsetsGeometry.all(16),
                child: SchemeIcon(makeIconic: it, size: 40),
              ),
            ),
        ],
      ),
    );
  }
}
