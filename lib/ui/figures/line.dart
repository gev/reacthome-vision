import 'dart:ui';

import 'package:studio/ui/figures/figure.dart';

class Line implements Figure {
  final Offset from;
  final Offset to;
  final Paint style;

  Line({required this.from, required this.to, required this.style});

  @override
  void paint(Canvas canvas) => canvas.drawLine(from, to, style);

  @override
  bool hitTest(Offset position) => false;
}
