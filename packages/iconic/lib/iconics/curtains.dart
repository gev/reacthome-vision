import 'dart:ui';

import 'package:iconic/iconic.dart';

const kCurtainsWidth = 0.5;
const kCurtainsSides = 0.3;
const kCurtainsHeight = 0.5;

class CurtainsIconic extends Iconic {
  final Path _path = Path();

  CurtainsIconic({
    required super.offset,
    required super.size,
    required super.style,
  }) {
    _path
      ..moveTo(offset.dx - curtainsWidth, offset.dy - curtainsHeight)
      ..relativeLineTo(curtainsWidth * 2, 0)
      ..relativeMoveTo(-curtainsWidth * 2, 0)
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

  double get curtainsSides => realSize * kCurtainsSides;
  double get curtainsHeight => realSize * kCurtainsHeight;
  double get curtainsWidth => realSize * kCurtainsWidth;

  @override
  double get weight => 0.8;

  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, stroke);
  }
}
