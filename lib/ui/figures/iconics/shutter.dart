import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const k2 = 0.5;
const k4 = 0.25;

class ShutterIconic extends Iconic {
  final double _size_2;
  ShutterIconic({required super.size, required super.iconicStyle})
    : _size_2 = size * k2;
  @override
  void paint(Canvas canvas, Offset offset) {
    canvas.drawLine(
      Offset(offset.dx - _size_2, offset.dy - _size_2),
      Offset(offset.dx + _size_2, offset.dy + _size_2),
      strokeStyle,
    );
    canvas.drawCircle(Offset(offset.dx, offset.dy), _size_2 * k4, strokeStyle);
  }
}

class HorizontalShutterIconic extends Iconic {
  final double _size_2;
  HorizontalShutterIconic({required super.size, required super.iconicStyle})
    : _size_2 = size * k2;
  @override
  void paint(Canvas canvas, Offset offset) {
    canvas.drawLine(
      Offset(offset.dx - _size_2, offset.dy),
      Offset(offset.dx + _size_2, offset.dy),
      strokeStyle,
    );
    canvas.drawCircle(Offset(offset.dx, offset.dy), _size_2 * k4, strokeStyle);
  }
}
