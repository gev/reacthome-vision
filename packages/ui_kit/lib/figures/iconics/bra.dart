import 'dart:ui';

import '../iconic.dart';

const kBraWidth = 0.12;
const kBraHeight = 0.5;
const kRectTop = 0.1;

class BraIconic extends Iconic {
  final Path _path = Path();

  BraIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  }) {
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
  double get braWidth => realSize * kBraWidth;
  double get braHeight => realSize * kBraHeight;
  double get rectHeight => realSize * kRectTop;

  @override
  double get weight => 0.75;

  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}
