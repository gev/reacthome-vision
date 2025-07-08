import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const kRectTop = 0.1;
const kRectWidth = 0.2;
const kArcRadius = 0.1;

class SpotIconic extends Iconic {
  final double halfSize;
  final double rectTop;
  final double rectWidth;
  final double arcRadius;

  final Path _path = Path();

  SpotIconic({required super.offset, required super.size, required super.iconicStyle})
    : halfSize = size / 2,
      rectTop = size * kRectTop,
      rectWidth = size * kRectWidth,
      arcRadius = size * kArcRadius {
    _path
      ..moveTo(offset.dx + (halfSize - rectWidth), offset.dy - halfSize)
      ..lineTo(offset.dx - (halfSize - rectWidth), offset.dy - halfSize)
      ..relativeArcToPoint(
        Offset(-rectWidth / 2, arcRadius),
        radius: Radius.circular(arcRadius),
        clockwise: false,
      )
      ..lineTo(offset.dx - (halfSize - rectWidth / 2), offset.dy - rectTop)
      ..moveTo(offset.dx + (halfSize - rectWidth), offset.dy - halfSize)
      ..relativeArcToPoint(
        Offset(rectWidth / 2, arcRadius),
        radius: Radius.circular(arcRadius),
        clockwise: true,
      )
      ..lineTo(offset.dx + (halfSize - rectWidth / 2), offset.dy - rectTop)
      ..addRect(
        Rect.fromPoints(
          Offset(offset.dx - halfSize, offset.dy - rectTop),
          Offset(offset.dx - (halfSize - rectWidth), offset.dy + halfSize),
        ),
      )
      ..addRect(
        Rect.fromPoints(
          Offset(offset.dx + (halfSize - rectWidth), offset.dy - rectTop),
          Offset(offset.dx + halfSize, offset.dy + halfSize),
        ),
      )
      ..close();
  }

  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}
