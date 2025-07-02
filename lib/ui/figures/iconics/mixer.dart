import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const k2 = 0.5;

class MixerIconic extends Iconic {
  final double _size_2;
  MixerIconic({required super.size, required super.iconicStyle})
    : _size_2 = size / 2;
  @override
  void paint(Canvas canvas, Offset offset) {
    canvas.drawLine(
      Offset(offset.dx, offset.dy),
      Offset(offset.dx, offset.dy + _size_2),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx - _size_2, offset.dy - _size_2),
      Offset(offset.dx, offset.dy),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx + _size_2, offset.dy - _size_2),
      Offset(offset.dx, offset.dy),
      strokeStyle,
    );
  }
}
