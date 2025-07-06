import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const k_curtains_width = 0.5;
const k_curtains_sides = 0.3;
const k_curtains_height = 0.5;

class CurtainsIconic extends Iconic {
  final double curtainsSides;
  final double curtainsHeight;
  final double curtainsWidth;
  final Path _path = Path();

  CurtainsIconic({required super.offset, required super.size, required super.iconicStyle})
    : curtainsSides = size * k_curtains_sides,
      curtainsHeight = size * k_curtains_height,
      curtainsWidth = size * k_curtains_width {
    _path
      ..moveTo(offset.dx - curtainsWidth, offset.dy - curtainsHeight)
      ..relativeLineTo(size, 0)
      ..relativeMoveTo(-size, 0)
      ..addRect(
        Rect.fromPoints(
          Offset(offset.dx - curtainsWidth, offset.dy - curtainsHeight),
          Offset(offset.dx - curtainsSides, offset.dy + curtainsHeight),
        ),
      )
      ..addRect(
        Rect.fromPoints(
          Offset(offset.dx + curtainsSides, offset.dy + curtainsHeight),
          Offset(offset.dx + curtainsWidth, offset.dy - curtainsHeight),
        ),
      );
  }

  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}
