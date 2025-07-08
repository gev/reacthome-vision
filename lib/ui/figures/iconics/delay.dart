import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:studio/ui/figures/iconic.dart';

const kDelayPosition = 0.2;
const kDelayHeight = 0.2;

class DelayIconic extends Iconic {
  final double halfSize;
  final double delayPosition;
  final double delayHeight;
  final Path _path = Path();
  DelayIconic({required super.offset, required super.size, required super.iconicStyle})
    : halfSize = size / 2,
      delayPosition = size * kDelayPosition,
      delayHeight = size * kDelayHeight {
    _path
      ..moveTo(offset.dx - halfSize, offset.dy + delayPosition)
      ..relativeLineTo(size, 0)
      ..relativeLineTo(0, -delayHeight);
  }
  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}
