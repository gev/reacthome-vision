import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:studio/ui/figures/iconic.dart';

class MinusIconic extends Iconic {
  final double _size_2;
  MinusIconic({required super.size, required super.iconicStyle})
    : _size_2 = size / 2;
  @override
  void paint(Canvas canvas, Offset offset) {
    canvas.drawLine(
      Offset(offset.dx - _size_2, offset.dy),
      Offset(offset.dx + _size_2, offset.dy),
      strokeStyle,
    );
  }
}
