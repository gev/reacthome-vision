import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const k2 = 0.5;
const k4 = 0.75;

class SPIconic extends Iconic {
  final double _size_2;
  SPIconic({required super.size, required super.iconicStyle})
    : _size_2 = size * k2;
  @override
  void paint(Canvas canvas, Offset offset) {
    canvas.drawLine(
      Offset(offset.dx - _size_2, offset.dy + _size_2 * k4),
      Offset(offset.dx + _size_2, offset.dy - _size_2 * k4),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx - _size_2, offset.dy - _size_2 * k4),
      Offset(offset.dx + _size_2, offset.dy + _size_2 * k4),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx - _size_2, offset.dy - _size_2 * k4),
      Offset(offset.dx - _size_2, offset.dy + _size_2 * k4),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx + _size_2, offset.dy - _size_2 * k4),
      Offset(offset.dx + _size_2, offset.dy + _size_2 * k4),
      strokeStyle,
    );
  }
}

class VerticalSPIconic extends Iconic {
  final double _size_2;
  VerticalSPIconic({required super.size, required super.iconicStyle})
    : _size_2 = size * k2;
  @override
  void paint(Canvas canvas, Offset offset) {
    canvas.drawLine(
      Offset(offset.dx - _size_2 * k4, offset.dy - _size_2),
      Offset(offset.dx + _size_2 * k4, offset.dy - _size_2),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx - _size_2 * k4, offset.dy + _size_2),
      Offset(offset.dx + _size_2 * k4, offset.dy + _size_2),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx + _size_2 * k4, offset.dy - _size_2),
      Offset(offset.dx - _size_2 * k4, offset.dy + _size_2),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx - _size_2 * k4, offset.dy - _size_2),
      Offset(offset.dx + _size_2 * k4, offset.dy + _size_2),
      strokeStyle,
    );
  }
}
