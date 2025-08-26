import 'package:flutter/material.dart';
import 'package:ui_kit/figures/figure.dart';

abstract class Node implements Paintable, Hittable {
  final Offset center;
  final NodeStyle style;

  Node({required this.center, required this.style});

  Node moveTo(Offset offset);

  Node moveBy(Offset offset) => moveTo(center + offset);

  void paintSelection(Canvas canvas);

  void paintFocus(Canvas canvas);
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
    this.sigma = 3.0,
  }) : background = Paint()
         ..style = PaintingStyle.fill
         ..color = backgroundColor,
       //  ..imageFilter = ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
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
