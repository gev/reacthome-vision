import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const kScreenWidth = 0.5;
const kScreenHeight = 0.5;
const kScreenTop = 0.35;

class ScreenIconic extends Iconic {
  final Path _path = Path();
  final double screenWidth;
  final double screenHeight;
  final double screenTop;
  ScreenIconic({required super.offset, required super.size, required super.iconicStyle})
    : screenWidth = size * kScreenWidth,
      screenHeight = size * kScreenHeight,
      screenTop = size * kScreenTop {
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
  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}
