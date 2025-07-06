import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const kHeaterHeight = 0.4;
const kArcRadius = kHeaterHeight / 2;

class HeaterIconic extends Iconic {
  final double heaterHeight;
  final double arcRadius;
  final Path _path = Path();

  HeaterIconic({required super.offset, required super.size, required super.iconicStyle})
    : heaterHeight = size * kHeaterHeight,
      arcRadius = size * kArcRadius {
    _path
      ..moveTo(offset.dx + size / 2, offset.dy - heaterHeight)
      ..relativeLineTo(-(size - arcRadius), 0)
      ..relativeArcToPoint(
        Offset(0, heaterHeight),
        radius: Radius.circular(arcRadius),
        clockwise: false,
      )
      ..relativeLineTo(size - arcRadius * 2, 0)
      ..relativeArcToPoint(Offset(0, heaterHeight), radius: Radius.circular(arcRadius))
      ..relativeLineTo(-(size - arcRadius), 0);
  }

  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}
