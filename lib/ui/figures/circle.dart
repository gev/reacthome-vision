import 'dart:ui';

import 'package:studio/ui/figures/figure.dart';

class Circle implements Figure {
  final Offset center;
  final double radius;
  final double radiusSquared;
  final Paint style;

  Circle({required this.center, required this.radius, required this.style})
    : radiusSquared = radius * radius;

  @override
  void paint(Canvas canvas) => canvas.drawCircle(center, radius, style);

  @override
  bool hitTest(Offset position) =>
      (position - center).distanceSquared < radiusSquared;
}
