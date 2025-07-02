import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const k_bar_length = 0.6;
const k_bar_gap = 0.4;

abstract class BarIconic extends Iconic {
  final double barGap;
  final double barLength;

  BarIconic({required super.size, required super.iconicStyle})
    : barGap = size * k_bar_gap,
      barLength = size * k_bar_length;
}

class HorizontalBarIconic extends BarIconic {
  HorizontalBarIconic({required super.size, required super.iconicStyle});

  @override
  void paint(Canvas canvas) {
    // canvas.drawLine(
    //   Offset(offset.dx - barLength, offset.dy),
    //   Offset(offset.dx + barLength, offset.dy),
    //   strokeStyle,
    // );
    // canvas.drawLine(
    //   Offset(offset.dx - barLength, offset.dy - barGap),
    //   Offset(offset.dx + barLength, offset.dy - barGap),
    //   strokeStyle,
    // );
    // canvas.drawLine(
    //   Offset(offset.dx - barLength, offset.dy + barGap),
    //   Offset(offset.dx + barLength, offset.dy + barGap),
    //   strokeStyle,
    // );
  }
}

class VerticalBarIconic extends BarIconic {
  VerticalBarIconic({required super.size, required super.iconicStyle});

  @override
  void paint(Canvas canvas) {
    // canvas.drawLine(
    //   Offset(offset.dx - barGap, offset.dy - barLength),
    //   Offset(offset.dx - barGap, offset.dy + barLength),
    //   strokeStyle,
    // );
    // canvas.drawLine(
    //   Offset(offset.dx, offset.dy - barLength),
    //   Offset(offset.dx, offset.dy + barLength),
    //   strokeStyle,
    // );
    // canvas.drawLine(
    //   Offset(offset.dx + barGap, offset.dy - barLength),
    //   Offset(offset.dx + barGap, offset.dy + barLength),
    //   strokeStyle,
    // );
  }
}
