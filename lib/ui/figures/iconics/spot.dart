import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const kSpotHeight = 0.5;
const kSpotWidth = 0.5;
const kRectTop = 0.3;
const kRectWidth = 0.35;
const kArcRadius = 0.18;

class SpotIconic extends Iconic {
  final double spotHeight;
  final double spotWidth;
  final double rectTop;
  final double rectWidth;
  final double arcRadius;

  final Path _path = Path();

  SpotIconic({required super.offset, required super.size, required super.iconicStyle})
    : spotHeight = size * kSpotHeight,
      spotWidth = size * kSpotWidth,
      rectTop = size * kRectTop,
      rectWidth = size * kRectWidth,
      arcRadius = size * kArcRadius {
    _path
      ..moveTo(offset.dx - (spotHeight - rectWidth / 2), offset.dy - rectTop)
      ..relativeArcToPoint(
        Offset(rectWidth / 2, -(spotHeight - rectTop)),
        radius: Radius.elliptical(arcRadius, arcRadius),
      )
      ..lineTo(offset.dx + (spotWidth - rectWidth), offset.dy - spotHeight)
      ..relativeArcToPoint(
        Offset(rectWidth / 2, (spotHeight - rectTop)),
        radius: Radius.elliptical(arcRadius, arcRadius),
      )
      ..addRect(
        Rect.fromPoints(
          Offset(offset.dx - spotWidth, offset.dy - rectTop),
          Offset(offset.dx - (spotHeight - rectWidth), offset.dy + spotHeight),
        ),
      )
      ..addRect(
        Rect.fromPoints(
          Offset(offset.dx + (spotHeight - rectWidth), offset.dy - rectTop),
          Offset(offset.dx + spotWidth, offset.dy + spotHeight),
        ),
      )
      ..close();
  }

  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}
