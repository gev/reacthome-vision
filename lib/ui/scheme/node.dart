import 'package:flutter/material.dart';
import 'package:studio/core/item.dart';
import 'package:studio/ui/figures/figure.dart';

class Node<Id> implements Figure {
  final Id id;
  Offset center;
  final double radius;
  final double radiusSelected;
  final double radiusSquared;
  final Paint style;
  final Paint styleSelected;

  Node({
    required Item<Id> item,
    required double gap,
    this.radius = 24,
    required Color color,
    required Color selectedColor,
  }) : id = item.id,
       radiusSelected = radius + 12,
       radiusSquared = radius * radius,
       center = Offset(gap * (item.x + 0.5), gap * (item.y + 0.5)),
       style = paintStyle(
         style: PaintingStyle.stroke,
         color: color,
         strokeWidth: 4,
       ),
       styleSelected = paintStyle(
         style: PaintingStyle.stroke,
         color: selectedColor,
         strokeWidth: 1,
       );

  void moveBy(Offset offset) {
    center += offset;
  }

  @override
  void paint(Canvas canvas) {
    canvas.drawCircle(center, radius, style);
  }

  void paintSelection(Canvas canvas) {
    canvas.drawCircle(center, radiusSelected, styleSelected);
  }

  @override
  bool hitTest(Offset position) =>
      (position - center).distanceSquared < radiusSquared;
}
