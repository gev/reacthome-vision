import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

// const k3 = 0.33;
class QFIconic extends Iconic {
  final double _size_3;
  QFIconic({required super.size, required super.iconicStyle})
    : _size_3 = size / 3;
  @override
  void paint(Canvas canvas, Offset offset) {
    canvas.drawLine(
      Offset(offset.dx, offset.dy - _size_3 * 2),
      Offset(offset.dx, offset.dy - _size_3),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx, offset.dy - _size_3),
      Offset(offset.dx + _size_3, offset.dy + _size_3 * 0.5),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx, offset.dy + _size_3 * 2),
      Offset(offset.dx, offset.dy + _size_3),
      strokeStyle,
    );
  }
}
