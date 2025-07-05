import 'dart:ui';

import 'package:studio/core/item.dart';
import 'package:studio/ui/figures/figure.dart';
import 'package:studio/ui/figures/iconic.dart';
import 'package:studio/ui/scheme/iconic_factory.dart';

class Node implements Paintable, Hittable {
  final ItemType type;
  final double radius;
  final double radiusFocussed;
  final double radiusSelected;
  final double _radiusSquared;
  final NodeStyle style;
  final Offset center;
  final Iconic _iconic;

  Node({
    required this.type,
    this.radius = 24,
    this.radiusFocussed = 36,
    this.radiusSelected = 48,
    required this.center,
    required this.style,
  }) : _radiusSquared = radius * radius,
       _iconic = selectIconic(type, center);

  Node moveTo(Offset offset) => Node(
    type: type,
    center: offset,
    radius: radius,
    radiusFocussed: radiusFocussed,
    radiusSelected: radiusSelected,
    style: style,
  );

  Node moveBy(Offset offset) => moveTo(center + offset);

  @override
  void paint(Canvas canvas) {
    canvas.drawCircle(center, radius + style.sigma, style.background);
    canvas.drawCircle(center, radius, style.fill);
    canvas.drawCircle(center, radius, style.stroke);
    _iconic.paint(canvas);
  }

  void paintSelection(Canvas canvas) {
    canvas.drawCircle(center, radiusSelected, style.selected);
  }

  void paintFocus(Canvas canvas) {
    canvas.drawCircle(center, radiusFocussed, style.focused);
  }

  @override
  bool hitTest(Offset position) => (position - center).distanceSquared < _radiusSquared;
}

class NodeStyle {
  final Paint background;
  final Paint fill;
  final Paint stroke;
  final Paint selected;
  final Paint focused;
  double sigma;

  NodeStyle({
    required Color color,
    required Color backgroundColor,
    required Color selectedColor,
    required Color focusedColor,
    double strokeWidth = 2.0,
    double focussedWidth = 1.0,
    double selectedWidth = 0.5,
    this.sigma = 8.0,
  }) : background = Paint()
         ..style = PaintingStyle.fill
         ..color = backgroundColor
         ..imageFilter = ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
       fill = Paint()
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
