import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const k_sp_width = 0.5;
const k_sp_side = 0.35;

abstract class SPIconic extends Iconic {
  final double spWidth;
  final double spSide;
  SPIconic({required super.size, required super.iconicStyle})
    : spWidth = size * k_sp_width,
      spSide = size * k_sp_side;
}

class HorizontalSPIconic extends SPIconic {
  HorizontalSPIconic({required super.size, required super.iconicStyle});
  @override
  void paint(Canvas canvas) {
    // canvas.drawLine(
    //   Offset(offset.dx - spWidth, offset.dy - spSide),
    //   Offset(offset.dx - spWidth, offset.dy + spSide),
    //   strokeStyle,
    // );
    // canvas.drawLine(
    //   Offset(offset.dx - spWidth, offset.dy - spSide),
    //   Offset(offset.dx + spWidth, offset.dy + spSide),
    //   strokeStyle,
    // );
    // canvas.drawLine(
    //   Offset(offset.dx - spWidth, offset.dy + spSide),
    //   Offset(offset.dx + spWidth, offset.dy - spSide),
    //   strokeStyle,
    // );
    // canvas.drawLine(
    //   Offset(offset.dx + spWidth, offset.dy - spSide),
    //   Offset(offset.dx + spWidth, offset.dy + spSide),
    //   strokeStyle,
    // );
  }
}

class VerticalSPIconic extends SPIconic {
  VerticalSPIconic({required super.size, required super.iconicStyle});
  @override
  void paint(Canvas canvas) {
    // canvas.drawLine(
    //   Offset(offset.dx - spSide, offset.dy - spWidth),
    //   Offset(offset.dx + spSide, offset.dy - spWidth),
    //   strokeStyle,
    // );
    // canvas.drawLine(
    //   Offset(offset.dx - spSide, offset.dy + spWidth),
    //   Offset(offset.dx + spSide, offset.dy + spWidth),
    //   strokeStyle,
    // );
    // canvas.drawLine(
    //   Offset(offset.dx + spSide, offset.dy - spWidth),
    //   Offset(offset.dx - spSide, offset.dy + spWidth),
    //   strokeStyle,
    // );
    // canvas.drawLine(
    //   Offset(offset.dx - spSide, offset.dy - spWidth),
    //   Offset(offset.dx + spSide, offset.dy + spWidth),
    //   strokeStyle,
    // );
  }
}
