import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:studio/ui/figures/iconic.dart';

const kMinusLength = 0.5;

class MinusIconic extends Iconic {
  final double minusLength;
  final Path _path = Path();
  MinusIconic({required super.offset, required super.size, required super.iconicStyle})
    : minusLength = size * kMinusLength {
    _path
      ..moveTo(offset.dx - minusLength, offset.dy)
      ..lineTo(offset.dx + minusLength, offset.dy);
  }
  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}
