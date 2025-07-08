import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const kCurtainsWidth = 0.5;
const kCurtainsSides = 0.3;
const kCurtainsHeight = 0.5;

class CurtainsIconic extends Iconic {
  final double curtainsSides;
  final double curtainsHeight;
  final double curtainsWidth;
  final Path _path = Path();

  CurtainsIconic({required super.offset, required super.size, required super.iconicStyle})
    : curtainsSides = size * kCurtainsSides,
      curtainsHeight = size * kCurtainsHeight,
      curtainsWidth = size * kCurtainsWidth {
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
