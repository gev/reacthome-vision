import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const kBlindsGap = 0.2;
const kBlindsWidth = 0.5;

class BlindsIconic extends Iconic {
  final double blindsGap;
  final double blindsWidth;

  final Path _path = Path();

  BlindsIconic({required super.offset, required super.size, required super.iconicStyle})
    : blindsGap = size * kBlindsGap,
      blindsWidth = size * kBlindsWidth {
    _path
      ..moveTo(offset.dx - blindsWidth, offset.dy - blindsGap * 2)
      ..relativeLineTo(size, 0)
      ..relativeMoveTo(-size, blindsGap)
      ..relativeLineTo(size, 0)
      ..relativeMoveTo(-size, blindsGap)
      ..relativeLineTo(size, 0)
      ..relativeMoveTo(-size, blindsGap)
      ..relativeLineTo(size, 0)
      ..relativeMoveTo(-size, blindsGap)
      ..relativeLineTo(size, 0);
  }

  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}
