import 'dart:ui';

import '../iconic.dart';

const kHeaterHeight = 0.4;
const kArcRadius = kHeaterHeight / 2;

class HeaterIconic extends Iconic {
  final Path _path = Path();

  HeaterIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  }) {
    _path
      ..moveTo(offset.dx + realSize / 2, offset.dy - heaterHeight)
      ..relativeLineTo(-(realSize - arcRadius), 0)
      ..relativeArcToPoint(
        Offset(0, heaterHeight),
        radius: Radius.circular(arcRadius),
        clockwise: false,
      )
      ..relativeLineTo(realSize - arcRadius * 2, 0)
      ..relativeArcToPoint(
        Offset(0, heaterHeight),
        radius: Radius.circular(arcRadius),
      )
      ..relativeLineTo(-(realSize - arcRadius), 0);
  }
  double get heaterHeight => realSize * kHeaterHeight;
  double get arcRadius => realSize * kArcRadius;

  @override
  double get weight => 0.8;

  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}
