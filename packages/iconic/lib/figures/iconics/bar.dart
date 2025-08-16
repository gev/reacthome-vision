import 'dart:ui';

import 'package:iconic/figures/iconic.dart';

const kBarLength = 0.5;
const kBarGap = 0.35;

abstract class _BarIconic extends Iconic {
  final Path _path = Path();

  _BarIconic({
    required super.offset,
    required super.size,
    required super.style,
  });

  double get barGap => realSize * kBarGap;
  double get barLength => realSize * kBarLength;

  @override
  double get weight => 0.75;

  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}

class HorizontalBarIconic extends _BarIconic {
  HorizontalBarIconic({
    required super.offset,
    required super.size,
    required super.style,
  }) {
    _path
      ..moveTo(offset.dx - barLength, offset.dy - barGap)
      ..relativeLineTo(realSize, 0)
      ..relativeMoveTo(-realSize, barGap)
      ..relativeLineTo(realSize, 0)
      ..relativeMoveTo(-realSize, barGap)
      ..relativeLineTo(realSize, 0);
  }
}

class VerticalBarIconic extends _BarIconic {
  VerticalBarIconic({
    required super.offset,
    required super.size,
    required super.style,
  }) {
    _path
      ..moveTo(offset.dx - barGap, offset.dy - barLength)
      ..relativeLineTo(0, realSize)
      ..relativeMoveTo(barGap, -realSize)
      ..relativeLineTo(0, realSize)
      ..relativeMoveTo(barGap, -realSize)
      ..relativeLineTo(0, realSize);
  }
}
