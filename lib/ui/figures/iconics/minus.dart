import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

class MinusIcon extends Iconic {
  final double _size_2;
  MinusIcon({required super.size, required super.strokeStyle})
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
