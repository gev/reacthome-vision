import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const kCircleRadius = 0.15;
const kLinesGap = 0.19;

class TemperatureSensorIconic extends Iconic {
  final Path _path = Path();
  TemperatureSensorIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  }) : halfSize = size / 2 {
    _path
      ..moveTo(offset.dx, offset.dy - halfSize)
      ..lineTo(offset.dx, offset.dy + (halfSize - radius * 2))
      ..relativeMoveTo(0, -linesGap)
      ..relativeLineTo(radius, 0)
      ..relativeMoveTo(-radius, -linesGap)
      ..relativeLineTo(radius, 0)
      ..relativeMoveTo(-radius, -linesGap)
      ..relativeLineTo(radius, 0)
      ..addOval(
        Rect.fromCircle(
          center: Offset(offset.dx, offset.dy + halfSize - radius),
          radius: radius,
        ),
      );
  }

  double get radius => realSize * kCircleRadius;
  double get linesGap => realSize * kLinesGap;
  final double halfSize;

  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}
