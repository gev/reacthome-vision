import 'dart:ui';

import 'package:iconic/figures/iconic.dart';

const kScreenWidth = 0.5;
const kScreenHeight = 0.5;
const kScreenTop = 0.35;

class ScreenIconic extends Iconic {
  final Path _path = Path();
  ScreenIconic({
    required super.offset,
    required super.size,
    required super.style,
  }) {
    _path
      ..moveTo(offset.dx - screenWidth, offset.dy - screenTop)
      ..relativeLineTo(2 * screenWidth, 0)
      ..addRect(
        Rect.fromPoints(
          Offset(offset.dx - screenWidth, offset.dy + screenHeight),
          Offset(offset.dx + screenWidth, offset.dy - screenHeight),
        ),
      );
  }

  double get screenWidth => realSize * kScreenWidth;
  double get screenHeight => realSize * kScreenHeight;
  double get screenTop => realSize * kScreenTop;

  @override
  double get weight => 0.8;

  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}
