import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const k_screen_width = 0.5;
const k_screen_height = 0.5;
const k_screen_top = 0.35;

class ScreenIconic extends Iconic {
  final double screenWidth;
  final double screenHeight;
  final double screenTop;
  ScreenIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  }) : screenWidth = size * k_screen_width,
       screenHeight = size * k_screen_height,
       screenTop = size * k_screen_top;
  @override
  void paint(Canvas canvas) {
    // canvas.drawRect(
    //   Rect.fromPoints(
    //     Offset(offset.dx - screenWidth, offset.dy + screenHeight),
    //     Offset(offset.dx + screenWidth, offset.dy - screenHeight),
    //   ),
    //   strokeStyle,
    // );
    // canvas.drawLine(
    //   Offset(offset.dx - screenWidth, offset.dy - screenTop),
    //   Offset(offset.dx + screenWidth, offset.dy - screenTop),
    //   strokeStyle,
    // );
  }
}
