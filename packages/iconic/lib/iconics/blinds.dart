import 'dart:ui';

import 'package:iconic/iconic.dart';

const kBlindsGap = 0.2;
const kBlindsWidth = 0.5;

class BlindsIconic extends Iconic {
  final Path _path = Path();

  BlindsIconic({
    required super.offset,
    required super.size,
    required super.style,
  }) {
    _path
      ..moveTo(offset.dx - blindsWidth, offset.dy - blindsGap * 2)
      ..relativeLineTo(realSize, 0)
      ..relativeMoveTo(-realSize, blindsGap)
      ..relativeLineTo(realSize, 0)
      ..relativeMoveTo(-realSize, blindsGap)
      ..relativeLineTo(realSize, 0)
      ..relativeMoveTo(-realSize, blindsGap)
      ..relativeLineTo(realSize, 0)
      ..relativeMoveTo(-realSize, blindsGap)
      ..relativeLineTo(realSize, 0);
  }
  double get blindsGap => realSize * kBlindsGap;
  double get blindsWidth => realSize * kBlindsWidth;

  @override
  double get weight => 0.8;

  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}
