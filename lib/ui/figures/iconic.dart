import 'dart:ui';

import 'package:studio/ui/figures/figure.dart';

abstract class Iconic implements Paintable {
  final Offset offset;
  final double size;
  final Paint strokeStyle;

  double get realSize => size * weight;

  double get weight => 1;

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
