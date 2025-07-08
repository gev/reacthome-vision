import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const kCircleRadius = 0.15;
const kLinesGap = 0.19;

class TemperatureSensorIconic extends Iconic {
  final double halfSize;
  final double radius;
  final double linesGap;
  final Path _path = Path();
  TemperatureSensorIconic({required super.offset, required super.size, required super.iconicStyle})
    : halfSize = size / 2,
      radius = size * kCircleRadius,
      linesGap = size * kLinesGap {
    _path
      ..moveTo(offset.dx, offset.dy - halfSize)
      ..lineTo(offset.dx, offset.dy + (halfSize - radius * 2))
      ..relativeMoveTo(0, -linesGap)
      ..relativeLineTo(radius, 0)
      ..relativeMoveTo(-radius, -linesGap)
      ..relativeLineTo(radius, 0)
      ..relativeMoveTo(-radius, -linesGap)
      ..relativeLineTo(radius, 0)
      ..addOval(Rect.fromCircle(center: offset, radius: radius));
  }
  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}
