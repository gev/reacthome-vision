import 'package:flutter/material.dart';
import 'package:studio/core/item.dart';
import 'package:studio/ui/figures/figure.dart';
import 'package:studio/ui_kit/theme/theme.dart';

class Node<Id> implements Figure {
  final Id id;
  Offset center;
  final double radius;
  final double _radiusFocussed;
  final double _radiusSelected;
  final double _radiusSquared;
  final Paint _fillStyle;
  final Paint _strokeStyle;
  final Paint _selectedStyle;
  final Paint _focussedStyle;

  Node({
    required Item<Id> item,
    required double gap,
    this.radius = 24,
    required ThemeContainer theme,
  }) : id = item.id,
       _radiusFocussed = radius + 12,
       _radiusSelected = radius + 24,
       _radiusSquared = radius * radius,
       center = Offset(gap * item.x, gap * item.y),
       _strokeStyle = paintStyle(
         style: PaintingStyle.stroke,
         color: theme.bodyStyle.color,
         strokeWidth: 4,
       ),
       _fillStyle = paintStyle(
         style: PaintingStyle.fill,
         color: theme.backgroundColor.withAlpha(255),
       ),
       _focussedStyle = paintStyle(
         style: PaintingStyle.stroke,
         color: theme.primaryColor,
         strokeWidth: 2,
       ),
       _selectedStyle = paintStyle(
         style: PaintingStyle.stroke,
         color: theme.color.withAlpha(64),
         strokeWidth: 0.5,
       );

  void moveBy(Offset offset) {
    center += offset;
  }

  @override
  void paint(Canvas canvas) {
    canvas.drawCircle(center, radius, _fillStyle);
    canvas.drawCircle(center, radius, _strokeStyle);
  }

  void paintSelection(Canvas canvas) {
    canvas.drawCircle(center, _radiusSelected, _selectedStyle);
  }

  void paintFocus(Canvas canvas) {
    canvas.drawCircle(center, _radiusFocussed, _focussedStyle);
  }

  @override
  bool hitTest(Offset position) =>
      (position - center).distanceSquared < _radiusSquared;
}
