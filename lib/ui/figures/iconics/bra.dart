import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const kBraWidth = 0.2;
const kBraHeight = 0.5;
const kRectHeight = 0.2;

class BraIconic extends Iconic {
  final Path _path = Path();
  final double braWidth;
  final double braHeight;
  final double rectHeight;
  BraIconic({required super.offset, required super.size, required super.iconicStyle})
    : braWidth = size * kBraWidth,
      braHeight = size * kBraHeight,
      rectHeight = size * kRectHeight {
    _path
      ..moveTo(offset.dx, offset.dy - braHeight)
      ..relativeLineTo(0, braHeight - rectHeight)
      ..addRect(
        Rect.fromPoints(
          Offset(offset.dx - braWidth, offset.dy - rectHeight),
          Offset(offset.dx + braWidth, offset.dy + braHeight),
        ),
      );
  }
  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}
