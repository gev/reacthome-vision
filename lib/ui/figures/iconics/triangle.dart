import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const k_side_position = 0.35;
const k_side_length = 0.5;
const k_apex_position = 0.5;

abstract class TriangleIconic extends Iconic {
  final double sidePosition;
  final double sideLength;
  final double apexPosition;

  TriangleIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  }) : sidePosition = size * k_side_position,
       sideLength = size * k_side_length,
       apexPosition = size * k_apex_position;
}

class RightTriangleIconic extends TriangleIconic {
  RightTriangleIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  });

  @override
  void paint(Canvas canvas) {
    // canvas.drawLine(
    //   Offset(offset.dx - sidePosition, offset.dy - sideLength),
    //   Offset(offset.dx - sidePosition, offset.dy + sideLength),
    //   strokeStyle,
    // );
    // canvas.drawLine(
    //   Offset(offset.dx - sidePosition, offset.dy - sideLength),
    //   Offset(offset.dx + apexPosition, offset.dy),
    //   strokeStyle,
    // );
    // canvas.drawLine(
    //   Offset(offset.dx - sidePosition, offset.dy + sideLength),
    //   Offset(offset.dx + apexPosition, offset.dy),
    //   strokeStyle,
    // );
  }
}

class LeftTriangleIconic extends TriangleIconic {
  LeftTriangleIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  });

  @override
  void paint(Canvas canvas) {
    //   canvas.drawLine(
    //     Offset(offset.dx + sidePosition, offset.dy - sideLength),
    //     Offset(offset.dx + sidePosition, offset.dy + sideLength),
    //     strokeStyle,
    //   );
    //   canvas.drawLine(
    //     Offset(offset.dx + sidePosition, offset.dy - sideLength),
    //     Offset(offset.dx - apexPosition, offset.dy),
    //     strokeStyle,
    //   );
    //   canvas.drawLine(
    //     Offset(offset.dx + sidePosition, offset.dy + sideLength),
    //     Offset(offset.dx - apexPosition, offset.dy),
    //     strokeStyle,
    //   );
  }
}

class TopTriangleIconic extends TriangleIconic {
  TopTriangleIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  });

  @override
  void paint(Canvas canvas) {
    // canvas.drawLine(
    //   Offset(offset.dx - sideLength, offset.dy + sidePosition),
    //   Offset(offset.dx + sideLength, offset.dy + sidePosition),
    //   strokeStyle,
    // );
    // canvas.drawLine(
    //   Offset(offset.dx - sideLength, offset.dy + sidePosition),
    //   Offset(offset.dx, offset.dy - apexPosition),
    //   strokeStyle,
    // );
    // canvas.drawLine(
    //   Offset(offset.dx + sideLength, offset.dy + sidePosition),
    //   Offset(offset.dx, offset.dy - apexPosition),
    //   strokeStyle,
    // );
  }
}

class BottomTriangleIconic extends TriangleIconic {
  BottomTriangleIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  });

  @override
  void paint(Canvas canvas) {
    // canvas.drawLine(
    //   Offset(offset.dx - sideLength, offset.dy - sidePosition),
    //   Offset(offset.dx + sideLength, offset.dy - sidePosition),
    //   strokeStyle,
    // );
    // canvas.drawLine(
    //   Offset(offset.dx - sideLength, offset.dy - sidePosition),
    //   Offset(offset.dx, offset.dy + apexPosition),
    //   strokeStyle,
    // );
    // canvas.drawLine(
    //   Offset(offset.dx + sideLength, offset.dy - sidePosition),
    //   Offset(offset.dx, offset.dy + apexPosition),
    //   strokeStyle,
    // );
  }
}
