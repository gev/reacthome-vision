import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const kSidePosition = 0.35;
const kSideLength = 0.5;
const kApexPosition = 0.45;

abstract class TriangleIconic extends Iconic {
  final double sidePosition;
  final double sideLength;
  final double apexPosition;
  final Path _path = Path();

  TriangleIconic({required super.offset, required super.size, required super.iconicStyle})
    : sidePosition = size * kSidePosition,
      sideLength = size * kSideLength,
      apexPosition = size * kApexPosition;

  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}

class RightTriangleIconic extends TriangleIconic {
  RightTriangleIconic({required super.offset, required super.size, required super.iconicStyle}) {
    _path
      ..moveTo(offset.dx - sidePosition, offset.dy - sideLength)
      ..relativeLineTo(0, sideLength * 2)
      ..relativeLineTo(apexPosition * 2, -sideLength)
      ..relativeLineTo(-apexPosition * 2, -sideLength)
      ..close();
  }
}

class LeftTriangleIconic extends TriangleIconic {
  LeftTriangleIconic({required super.offset, required super.size, required super.iconicStyle}) {
    _path
      ..moveTo(offset.dx + sidePosition, offset.dy - sideLength)
      ..relativeLineTo(0, sideLength * 2)
      ..relativeLineTo(-apexPosition * 2, -sideLength)
      ..relativeLineTo(apexPosition * 2, -sideLength)
      ..close();
  }
}

class TopTriangleIconic extends TriangleIconic {
  TopTriangleIconic({required super.offset, required super.size, required super.iconicStyle}) {
    _path
      ..moveTo(offset.dx - sideLength, offset.dy + sidePosition)
      ..relativeLineTo(sideLength * 2, 0)
      ..relativeLineTo(-sideLength, -apexPosition * 2)
      ..relativeLineTo(-sideLength, apexPosition * 2)
      ..close();
  }
}

class BottomTriangleIconic extends TriangleIconic {
  BottomTriangleIconic({required super.offset, required super.size, required super.iconicStyle}) {
    _path
      ..moveTo(offset.dx - sideLength, offset.dy - sidePosition)
      ..relativeLineTo(sideLength * 2, 0)
      ..relativeLineTo(-sideLength, apexPosition * 2)
      ..relativeLineTo(-sideLength, -apexPosition * 2)
      ..close();
  }
}
