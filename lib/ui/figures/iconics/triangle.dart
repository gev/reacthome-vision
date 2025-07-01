import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const k_side_position = 0.35;
const k_side_length = 0.5;
const k_apex_position = 0.5;

class RightTriangleIconic extends Iconic {
  final double sidePosition;
  final double sideLength;
  final double apexPosition;
  RightTriangleIconic({required super.size, required super.iconicStyle})
    : sidePosition = size * k_side_position,
      sideLength = size * k_side_length,
      apexPosition = size * k_apex_position;
  @override
  void paint(Canvas canvas, Offset offset) {
    canvas.drawLine(
      Offset(offset.dx - sidePosition, offset.dy - sideLength),
      Offset(offset.dx - sidePosition, offset.dy + sideLength),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx - sidePosition, offset.dy - sideLength),
      Offset(offset.dx + apexPosition, offset.dy),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx - sidePosition, offset.dy + sideLength),
      Offset(offset.dx + apexPosition, offset.dy),
      strokeStyle,
    );
  }
}

class LeftTriangleIconic extends Iconic {
  final double sidePosition;
  final double sideLength;
  final double apexPosition;
  LeftTriangleIconic({required super.size, required super.iconicStyle})
    : sidePosition = size * k_side_position,
      sideLength = size * k_side_length,
      apexPosition = size * k_apex_position;
  @override
  void paint(Canvas canvas, Offset offset) {
    canvas.drawLine(
      Offset(offset.dx + sidePosition, offset.dy - sideLength),
      Offset(offset.dx + sidePosition, offset.dy + sideLength),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx + sidePosition, offset.dy - sideLength),
      Offset(offset.dx - apexPosition, offset.dy),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx + sidePosition, offset.dy + sideLength),
      Offset(offset.dx - apexPosition, offset.dy),
      strokeStyle,
    );
  }
}

class TopTriangleIconic extends Iconic {
  final double sidePosition;
  final double sideLength;
  final double apexPosition;
  TopTriangleIconic({required super.size, required super.iconicStyle})
    : sidePosition = size * k_side_position,
      sideLength = size * k_side_length,
      apexPosition = size * k_apex_position;
  @override
  void paint(Canvas canvas, Offset offset) {
    canvas.drawLine(
      Offset(offset.dx - sideLength, offset.dy + sidePosition),
      Offset(offset.dx + sideLength, offset.dy + sidePosition),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx - sideLength, offset.dy + sidePosition),
      Offset(offset.dx, offset.dy - apexPosition),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx + sideLength, offset.dy + sidePosition),
      Offset(offset.dx, offset.dy - apexPosition),
      strokeStyle,
    );
  }
}

class BottomTriangleIconic extends Iconic {
  final double sidePosition;
  final double sideLength;
  final double apexPosition;
  BottomTriangleIconic({required super.size, required super.iconicStyle})
    : sidePosition = size * k_side_position,
      sideLength = size * k_side_length,
      apexPosition = size * k_apex_position;
  @override
  void paint(Canvas canvas, Offset offset) {
    canvas.drawLine(
      Offset(offset.dx - sideLength, offset.dy - sidePosition),
      Offset(offset.dx + sideLength, offset.dy - sidePosition),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx - sideLength, offset.dy - sidePosition),
      Offset(offset.dx, offset.dy + apexPosition),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx + sideLength, offset.dy - sidePosition),
      Offset(offset.dx, offset.dy + apexPosition),
      strokeStyle,
    );
  }
}
