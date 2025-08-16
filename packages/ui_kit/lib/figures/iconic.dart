import 'dart:ui';

import 'figure.dart';

typedef IconicFactory =
    Iconic Function({
      required Offset offset,
      required double size,
      required IconicStyle style,
    });

abstract class Iconic implements Paintable {
  final Offset offset;
  final double size;
  final Paint strokeStyle;

  double get weight => 1;
  double get realSize => size * weight;

  Iconic({required this.offset, required this.size, required IconicStyle style})
    : strokeStyle = Paint()
        ..style = PaintingStyle.stroke
        ..strokeCap = style.cap
        ..strokeJoin = style.join
        ..strokeWidth = size * style.width
        ..color = style.color;
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

IconicStyle makeIconicStyle(Color color) =>
    IconicStyle(width: 0.01, color: color);
