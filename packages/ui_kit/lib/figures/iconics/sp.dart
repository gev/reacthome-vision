import 'dart:ui';

import '../iconic.dart';

const kSPWidth = 0.5;
const kSPSide = 0.35;

abstract class SPIconic extends Iconic {
  final Path _path = Path();
  SPIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  });

  double get spWidth => realSize * kSPWidth;
  double get spSide => realSize * kSPSide;

  @override
  double get weight => 0.8;

  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}

class HorizontalSPIconic extends SPIconic {
  HorizontalSPIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  }) {
    _path
      ..moveTo(offset.dx - spWidth, offset.dy - spSide)
      ..relativeLineTo(0, spSide * 2)
      ..relativeLineTo(spWidth * 2, -spSide * 2)
      ..relativeLineTo(0, spSide * 2)
      ..relativeLineTo(-spWidth * 2, -spSide * 2)
      ..close();
  }
}

class VerticalSPIconic extends SPIconic {
  VerticalSPIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  }) {
    _path
      ..moveTo(offset.dx - spSide, offset.dy - spWidth)
      ..relativeLineTo(spSide * 2, 0)
      ..relativeLineTo(-spSide * 2, spWidth * 2)
      ..relativeLineTo(spSide * 2, 0)
      ..relativeLineTo(-spSide * 2, -spWidth * 2)
      ..close();
  }
}
