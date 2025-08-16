import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iconic/iconic.dart';

const kDelayPosition = 0.1;
const kDelayHeight = 0.2;

class DelayIconic extends Iconic {
  final Path _path = Path();
  DelayIconic({
    required super.offset,
    required super.size,
    required super.style,
  }) {
    _path
      ..moveTo(offset.dx - halfSize, offset.dy + delayPosition)
      ..relativeLineTo(realSize, 0)
      ..relativeLineTo(0, -delayHeight);
  }
  double get halfSize => realSize / 2;
  double get delayPosition => realSize * kDelayPosition;
  double get delayHeight => realSize * kDelayHeight;

  @override
  double get weight => 0.75;

  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}
