import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const k2 = 0.5;
const k_triangle = 0.7;

class RightTriangleIconic extends Iconic {
  final double _size_2;
  RightTriangleIconic({required super.size, required super.iconicStyle})
    : _size_2 = size * k2;
  @override
  void paint(Canvas canvas, Offset offset) {
    canvas.drawLine(
      Offset(offset.dx - _size_2 * k_triangle, offset.dy - _size_2),
      Offset(offset.dx - _size_2 * k_triangle, offset.dy + _size_2),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx - _size_2 * k_triangle, offset.dy - _size_2),
      Offset(offset.dx + _size_2, offset.dy),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx - _size_2 * k_triangle, offset.dy + _size_2),
      Offset(offset.dx + _size_2, offset.dy),
      strokeStyle,
    );
  }
}

class LeftTriangleIconic extends Iconic {
  final double _size_2;
  LeftTriangleIconic({required super.size, required super.iconicStyle})
    : _size_2 = size * k2;
  @override
  void paint(Canvas canvas, Offset offset) {
    canvas.drawLine(
      Offset(offset.dx + _size_2 * k_triangle, offset.dy - _size_2),
      Offset(offset.dx + _size_2 * k_triangle, offset.dy + _size_2),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx + _size_2 * k_triangle, offset.dy - _size_2),
      Offset(offset.dx - _size_2, offset.dy),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx + _size_2 * k_triangle, offset.dy + _size_2),
      Offset(offset.dx - _size_2, offset.dy),
      strokeStyle,
    );
  }
}

class TopTriangleIconic extends Iconic {
  final double _size_2;
  TopTriangleIconic({required super.size, required super.iconicStyle})
    : _size_2 = size * k2;
  @override
  void paint(Canvas canvas, Offset offset) {
    canvas.drawLine(
      Offset(offset.dx - _size_2, offset.dy + _size_2 * k_triangle),
      Offset(offset.dx + _size_2, offset.dy + _size_2 * k_triangle),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx - _size_2, offset.dy + _size_2 * k_triangle),
      Offset(offset.dx, offset.dy - _size_2),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx + _size_2, offset.dy + _size_2 * k_triangle),
      Offset(offset.dx, offset.dy - _size_2),
      strokeStyle,
    );
  }
}

class BottomTriangleIconic extends Iconic {
  final double _size_2;
  BottomTriangleIconic({required super.size, required super.iconicStyle})
    : _size_2 = size * k2;
  @override
  void paint(Canvas canvas, Offset offset) {
    canvas.drawLine(
      Offset(offset.dx - _size_2, offset.dy - _size_2 * k_triangle),
      Offset(offset.dx + _size_2, offset.dy - _size_2 * k_triangle),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx - _size_2, offset.dy - _size_2 * k_triangle),
      Offset(offset.dx, offset.dy + _size_2),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx + _size_2, offset.dy - _size_2 * k_triangle),
      Offset(offset.dx, offset.dy + _size_2),
      strokeStyle,
    );
  }
}
