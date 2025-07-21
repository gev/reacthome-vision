import 'dart:ui';

import 'figure.dart';

abstract class Iconic implements Paintable {
  final Offset offset;
  final double size;
  final Paint strokeStyle;

  double get weight => 1;
  double get realSize => size * weight;

  Iconic({
    required this.offset,
    required this.size,
    required IconicStyle iconicStyle,
  }) : strokeStyle = Paint()
         ..style = PaintingStyle.stroke
         ..strokeCap = iconicStyle.cap
         ..strokeJoin = iconicStyle.join
         ..strokeWidth = size * iconicStyle.width
         ..color = iconicStyle.color;
}

class IconicStyle {
  final double width;
  final Color color;
  final StrokeCap cap;
  final StrokeJoin join;

  IconicStyle({
    required this.width,
    required this.color,
    this.cap = StrokeCap.round,
    this.join = StrokeJoin.miter,
  });
}
