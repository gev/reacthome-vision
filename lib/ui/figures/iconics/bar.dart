import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const k_bar_length = 0.5;
const k_bar_gap = 0.35;

abstract class BarIconic extends Iconic {
  final Offset offset;
  final double barGap;
  final double barLength;
  final Path _path = Path();

  BarIconic({
    required this.offset,
    required super.size,
    required super.iconicStyle,
  }) : barGap = size * k_bar_gap,
       barLength = size * k_bar_length;

  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}

class HorizontalBarIconic extends BarIconic {
  HorizontalBarIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  }) {
    _path
      ..moveTo(offset.dx - barLength, offset.dy - barGap)
      ..relativeLineTo(size, 0)
      ..relativeMoveTo(-size, barGap)
      ..relativeLineTo(size, 0)
      ..relativeMoveTo(-size, barGap)
      ..relativeLineTo(size, 0);
  }
}

class VerticalBarIconic extends BarIconic {
  VerticalBarIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  }) {
    _path
      ..moveTo(offset.dx - barGap, offset.dy - barLength)
      ..relativeLineTo(0, size)
      ..relativeMoveTo(barGap, -size)
      ..relativeLineTo(0, size)
      ..relativeMoveTo(barGap, -size)
      ..relativeLineTo(0, size);
  }
}
