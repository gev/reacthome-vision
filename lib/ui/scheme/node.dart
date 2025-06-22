import 'package:flutter/material.dart';
import 'package:studio/ui/figures/figure.dart';

class Node implements RelativeFigure {
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
  final Paint _fill;
  final Paint _stroke;
  final Paint _selected;
  final Paint _focussed;

  Paint get fill => _fill;
  Paint get stroke => _stroke;
  Paint get selected => _selected;
  Paint get focused => _focussed;

  NodeStyle({
    required Color color,
    required Color backgroundColor,
    required Color selectedColor,
    required Color focussedColor,
    double strokeWidth = 4.0,
    double focussedWidth = 2.0,
    double selectedWidth = 0.5,
  }) : _fill = Paint()
         ..style = PaintingStyle.fill
         ..color = backgroundColor,
       _stroke = Paint()
         ..style = PaintingStyle.stroke
         ..color = color
         ..strokeWidth = strokeWidth,
       _selected = Paint()
         ..style = PaintingStyle.stroke
         ..color = selectedColor
         ..strokeWidth = selectedWidth,
       _focussed = Paint()
         ..style = PaintingStyle.stroke
         ..color = focussedColor
         ..strokeWidth = focussedWidth;
}
