import 'package:flutter/material.dart';
import 'package:studio/ui/figures/figure.dart';

class Node implements PaintableAt, HittableAt {
  final double radius;
  final double radiusFocussed;
  final double radiusSelected;
  final double _radiusSquared;
  final NodeStyle style;

  Node({
    this.radius = 24,
    this.radiusFocussed = 36,
    this.radiusSelected = 48,
    required this.style,
  }) : _radiusSquared = radius * radius;

  @override
  void paint(Canvas canvas, Offset center) {
    canvas.drawCircle(center, radius, style.fill);
    canvas.drawCircle(center, radius, style.stroke);
  }

  void paintSelection(Canvas canvas, Offset center) {
    canvas.drawCircle(center, radiusSelected, style.selected);
  }

  void paintFocus(Canvas canvas, Offset center) {
    canvas.drawCircle(center, radiusFocussed, style.focused);
  }

  @override
  bool hitTest(Offset position, Offset center) =>
      (position - center).distanceSquared < _radiusSquared;
}

class NodeStyle {
  final Paint fill;
  final Paint stroke;
  final Paint selected;
  final Paint focused;

  NodeStyle({
    required Color color,
    required Color backgroundColor,
    required Color selectedColor,
    required Color focusedColor,
    double strokeWidth = 4.0,
    double focussedWidth = 2.0,
    double selectedWidth = 0.5,
  }) : fill = Paint()
         ..style = PaintingStyle.fill
         ..color = backgroundColor,
       stroke = Paint()
         ..style = PaintingStyle.stroke
         ..color = color
         ..strokeWidth = strokeWidth,
       selected = Paint()
         ..style = PaintingStyle.stroke
         ..color = selectedColor
         ..strokeWidth = selectedWidth,
       focused = Paint()
         ..style = PaintingStyle.stroke
         ..color = focusedColor
         ..strokeWidth = focussedWidth;
}
