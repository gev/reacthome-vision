import 'dart:ui';

import '../iconic.dart';

const kLedLength = 0.8;
const kLedHeight = 0.2;
const kCircleRadius = 0.08;

class LedIconic extends Iconic {
  final Path _path = Path();

  LedIconic({
    required super.offset,
    required super.size,
    required super.style,
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
      ..addOval(
        Rect.fromCircle(
          center: Offset(offset.dx - ledLength / 2.3, offset.dy),
          radius: circleRadius,
        ),
      )
      ..addOval(
        Rect.fromCircle(
          center: Offset(offset.dx, offset.dy),
          radius: circleRadius,
        ),
      )
      ..addOval(
        Rect.fromCircle(
          center: Offset(offset.dx + ledLength / 2.3, offset.dy),
          radius: circleRadius,
        ),
      );
  }

  double get ledLength => realSize * kLedLength;
  double get ledHeight => realSize * kLedHeight;
  double get circleRadius => realSize * kCircleRadius;

  @override
  double get weight => 0.8;
  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}
