import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iconic/figures/iconic.dart';

const kMinusSize = 0.5;

class MinusIconic extends Iconic {
  final Path _path = Path();
  MinusIconic({
    required super.offset,
    required super.size,
    required super.style,
  }) {
    _path
      ..moveTo(offset.dx - minusSize, offset.dy)
      ..lineTo(offset.dx + minusSize, offset.dy);
  }

  double get minusSize => realSize * kMinusSize;

  @override
  double get weight => 0.9;

  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}
