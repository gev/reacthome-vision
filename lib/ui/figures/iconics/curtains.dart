import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const k2 = 0.5;
const k_curtains = 0.6;

class CurtainsIconic extends Iconic {
  final double _size_2;
  CurtainsIconic({required super.size, required super.iconicStyle})
    : _size_2 = size * k2;
  @override
  void paint(Canvas canvas, Offset offset) {
    canvas.drawRect(
      Rect.fromPoints(
        Offset(offset.dx + _size_2 * k_curtains, offset.dy - _size_2),
        Offset(offset.dx + _size_2, offset.dy + _size_2),
      ),
      strokeStyle,
    );
    canvas.drawRect(
      Rect.fromPoints(
        Offset(offset.dx - _size_2, offset.dy + _size_2),
        Offset(offset.dx - _size_2 * k_curtains, offset.dy - _size_2),
      ),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx - _size_2, offset.dy - _size_2),
      Offset(offset.dx + _size_2, offset.dy - _size_2),
      strokeStyle,
    );
  }
}
