import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:studio/ui/figures/iconic.dart';

const k_minus_length = 0.5;

class MinusIconic extends Iconic {
  final double minusLength;
  MinusIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  }) : minusLength = size * k_minus_length;
  @override
  void paint(Canvas canvas) {
    // canvas.drawLine(
    //   Offset(offset.dx - minusLength, offset.dy),
    //   Offset(offset.dx + minusLength, offset.dy),
    //   strokeStyle,
    // );
  }
}
