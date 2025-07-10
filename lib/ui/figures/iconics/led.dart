import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const kLedLength = 0.8;
const kLedHeight = 0.2;
const kCircleRadius = 0.1;

class LedIconic extends Iconic {
  final Path _path = Path();

  LedIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  }) {
    _path
      ..moveTo(offset.dx - ledLength / 2, offset.dy - ledHeight)
      ..relativeLineTo(ledLength, 0)
      ..relativeArcToPoint(
        Offset(0, ledHeight * 2),
        radius: Radius.circular(ledHeight),
        clockwise: true,
      )
      ..relativeLineTo(-ledLength, 0)
      ..relativeArcToPoint(
        Offset(0, -ledHeight * 2),
        radius: Radius.circular(ledHeight),
        clockwise: true,
      )
      ..moveTo(offset.dx - ledLength / 2.5, offset.dy - ledHeight)
      ..addOval(Rect.fromCircle(center: offset, radius: circleRadius))
      ..moveTo(offset.dx + ledLength / 2.5, offset.dy - ledHeight)
      ..addOval(Rect.fromCircle(center: offset, radius: circleRadius))
      ..moveTo(offset.dx, offset.dy - circleRadius)
      ..addOval(Rect.fromCircle(center: offset, radius: circleRadius));
  }

  double get ledLength => realSize * kLedLength;
  double get ledHeight => realSize * kLedHeight;
  double get circleRadius => realSize * kCircleRadius;
  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}
