import 'package:flutter/material.dart';
import 'package:studio/ui/figures/figure.dart';

class Node implements Figure {
  Offset center;
  final double radius;
  final double radiusFocussed;
  final double radiusSelected;
  final double _radiusSquared;
  final NodeStyle style;

  Node({
    required this.center,
    this.radius = 24,
    this.radiusFocussed = 36,
    this.radiusSelected = 48,
    required this.style,
  }) : _radiusSquared = radius * radius;

  void moveBy(Offset offset) {
    center += offset;
  }

  @override
  void paint(Canvas canvas) {
    canvas.drawCircle(center, radius, style.fill);
    canvas.drawCircle(center, radius, style.stroke);
  }

  void paintSelection(Canvas canvas) {
    canvas.drawCircle(center, radiusSelected, style.selected);
  }

  void paintFocus(Canvas canvas) {
    canvas.drawCircle(center, radiusFocussed, style.focused);
  }

  @override
  bool hitTest(Offset position) =>
      (position - center).distanceSquared < _radiusSquared;
}

class NodeStyle {
  final Paint _fillStyle;
  final Paint _strokeStyle;
  final Paint _selectedStyle;
  final Paint _focussedStyle;

  Paint get fill => _fillStyle;
  Paint get stroke => _strokeStyle;
  Paint get selected => _selectedStyle;
  Paint get focused => _focussedStyle;

  NodeStyle({
    required Color color,
    required Color backgroundColor,
    required Color selectedColor,
    required Color focussedColor,
    double strokeWidth = 4.0,
    double focussedWidth = 2.0,
    double selectedWidth = 0.5,
  }) : _fillStyle = Paint()
         ..style = PaintingStyle.fill
         ..color = backgroundColor,
       _strokeStyle = Paint()
         ..style = PaintingStyle.stroke
         ..color = color
         ..strokeWidth = strokeWidth,
       _selectedStyle = Paint()
         ..style = PaintingStyle.stroke
         ..color = selectedColor
         ..strokeWidth = selectedWidth,
       _focussedStyle = Paint()
         ..style = PaintingStyle.stroke
         ..color = focussedColor
         ..strokeWidth = focussedWidth;
}
