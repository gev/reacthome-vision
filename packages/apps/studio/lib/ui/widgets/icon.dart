import 'package:flutter/widgets.dart';
import 'package:ui_kit/figures/iconic.dart';

class Icon extends StatelessWidget {
  final Iconic iconic;

  const Icon({required this.iconic, super.key});

  @override
  Widget build(BuildContext context) => CustomPaint(
    painter: _IconicPainter(iconic),
    size: Size(iconic.size, iconic.size),
  );
}

class _IconicPainter extends CustomPainter {
  final Iconic iconic;

  const _IconicPainter(this.iconic);

  @override
  void paint(Canvas canvas, Size size) {
    iconic.paint(canvas);
  }

  @override
  bool shouldRepaint(covariant _IconicPainter oldDelegate) => false;
}
