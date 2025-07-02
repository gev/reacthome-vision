import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const k_curtains_width = 0.6;
const k_curtains_sides = 0.4;
const k_curtains_height = 0.6;

class CurtainsIconic extends Iconic {
  final double curtainsSides;
  final double curtainsHeight;
  final double curtainsWidth;
  CurtainsIconic({required super.size, required super.iconicStyle})
    : curtainsSides = size * k_curtains_sides,
      curtainsHeight = size * k_curtains_height,
      curtainsWidth = size * k_curtains_width;

  @override
  void paint(Canvas canvas) {
    // canvas.drawRect(
    //   Rect.fromPoints(
    //     Offset(offset.dx + curtainsSides, offset.dy - curtainsHeight),
    //     Offset(offset.dx + curtainsWidth, offset.dy + curtainsHeight),
    //   ),
    //   strokeStyle,
    // );
    // canvas.drawRect(
    //   Rect.fromPoints(
    //     Offset(offset.dx - curtainsWidth, offset.dy + curtainsHeight),
    //     Offset(offset.dx - curtainsSides, offset.dy - curtainsHeight),
    //   ),
    //   strokeStyle,
    // );
    // canvas.drawLine(
    //   Offset(offset.dx - curtainsWidth, offset.dy - curtainsHeight),
    //   Offset(offset.dx + curtainsWidth, offset.dy - curtainsHeight),
    //   strokeStyle,
    // );
  }
}
