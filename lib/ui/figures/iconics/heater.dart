import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const kLine = 0.5;
const kLineToArc = 0.9;
const kMiddleLineToArc = 0.7;
const kHeaterGap = 0.4;
const kArc = 0.2;

class HeaterIconic extends Iconic {
  final double heaterLine;
  final double lineToArc;
  final double middleLineToArc;
  final double heaterGap;
  final Path _path = Path();

  final Offset a = Offset(0, 0);
  final Offset b = Offset(0, 0);

  HeaterIconic({required super.offset, required super.size, required super.iconicStyle})
    : heaterGap = size * kHeaterGap,
      heaterLine = size * kLine,
      lineToArc = size * kLineToArc,
      middleLineToArc = size * kMiddleLineToArc {
    _path
      ..moveTo(offset.dx + heaterLine, offset.dy - heaterGap)
      ..relativeLineTo(-lineToArc, 0)
      ..relativeArcToPoint(
        Offset(-size * kArc, size * kArc),
        radius: Radius.elliptical(size * kArc, size * kArc),
        clockwise: false,
      )
      ..relativeArcToPoint(
        Offset(size * kArc, size * kArc),
        radius: Radius.elliptical(size * kArc, size * kArc),
        clockwise: false,
      )
      ..relativeLineTo(middleLineToArc, 0)
      ..relativeArcToPoint(
        Offset(size * kArc, size * kArc),
        radius: Radius.elliptical(size * kArc, size * kArc),
        clockwise: true,
      )
      ..relativeArcToPoint(
        Offset(-size * kArc, size * kArc),
        radius: Radius.elliptical(size * kArc, size * kArc),
        clockwise: true,
      )
      ..relativeLineTo(-lineToArc, 0);
  }

  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}
