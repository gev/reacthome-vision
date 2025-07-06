import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const k_screen_width = 0.5;
const k_screen_height = 0.5;
const k_screen_top = 0.35;

class ScreenIconic extends Iconic {
  final Path _path = Path();
  final double screenWidth;
  final double screenHeight;
  final double screenTop;
  ScreenIconic({required super.offset, required super.size, required super.iconicStyle})
    : screenWidth = size * k_screen_width,
      screenHeight = size * k_screen_height,
      screenTop = size * k_screen_top {
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
