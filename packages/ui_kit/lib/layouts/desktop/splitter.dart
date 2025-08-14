import 'package:flutter/widgets.dart';
import 'package:ui_kit/layouts/desktop/sidebar_controller.dart';

abstract class Splitter extends StatelessWidget {
  final double size;
  final SidebarController controller;
  const Splitter({double? size, required this.controller, super.key})
    : size = size ?? 4;

  double delta(DragUpdateDetails details);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        controller.resizeBy(delta(details));
      },
      child: const MouseRegion(
        cursor: SystemMouseCursors.resizeLeftRight,
        child: SizedBox(width: 4, height: double.infinity),
      ),
    );
  }
}

class StartSplitter extends Splitter {
  const StartSplitter({super.size, required super.controller, super.key});

  @override
  double delta(DragUpdateDetails details) => details.delta.dx;
}

class EndSplitter extends Splitter {
  const EndSplitter({super.size, required super.controller, super.key});

  @override
  double delta(DragUpdateDetails details) => -details.delta.dx;
}
