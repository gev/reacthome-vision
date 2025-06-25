import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

class PlusIconic extends Iconic {
  final double _size_2;
  PlusIconic({required super.size, required super.iconicStyle})
    : _size_2 = size / 2;
  @override
  void paint(Canvas canvas, Offset offset) {
    canvas.drawLine(
      Offset(offset.dx - _size_2, offset.dy),
      Offset(offset.dx + _size_2, offset.dy),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx, offset.dy - _size_2),
      Offset(offset.dx, offset.dy + _size_2),
      strokeStyle,
    );
  }
}
