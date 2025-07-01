import 'package:flutter/material.dart';
import 'package:studio/core/item.dart';
import 'package:studio/ui/figures/figure.dart';
import 'package:studio/ui/figures/iconic.dart';
import 'package:studio/ui/figures/iconics/minus.dart';
import 'package:studio/ui/figures/iconics/plus.dart';

Iconic selectIconic(ItemType type) => switch (type) {
  ItemType.plus => PlusIconic(
    size: 24,
    iconicStyle: IconicStyle(width: 0.1, color: Colors.red[800]!),
  ),
  ItemType.minus => MinusIconic(
    size: 24,
    iconicStyle: IconicStyle(width: 0.1, color: Colors.blue[800]!),
  ),
};

class Node implements Paintable, Hittable {
  final double radius;
  final double radiusFocussed;
  final double radiusSelected;
  final double _radiusSquared;
  final NodeStyle style;
  final Offset center;

  final Iconic iconic;

  Node({
    this.radius = 24,
    this.radiusFocussed = 36,
    this.radiusSelected = 48,
    required this.center,
    required this.style,
    required this.iconic,
  }) : _radiusSquared = radius * radius;

  Node moveTo(Offset offset) => Node(
    center: offset,
    radius: radius,
    radiusFocussed: radiusFocussed,
    radiusSelected: radiusSelected,
    style: style,
    iconic: iconic,
  );

  Node moveBy(Offset offset) => moveTo(center + offset);

  @override
  void paint(Canvas canvas) {
    canvas.drawCircle(center, radius, style.fill);
    canvas.drawCircle(center, radius, style.stroke);
    iconic.paint(canvas, center);
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
