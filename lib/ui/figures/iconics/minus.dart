import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:studio/ui/figures/iconic.dart';

const k_minus_length = 0.5;

class MinusIconic extends Iconic {
  final double minusLength;
  final Path _path = Path();
  MinusIconic({required super.offset, required super.size, required super.iconicStyle})
    : minusLength = size * k_minus_length {
    _path
      ..moveTo(offset.dx - minusLength, offset.dy)
      ..lineTo(offset.dx + minusLength, offset.dy);
  }
  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}
