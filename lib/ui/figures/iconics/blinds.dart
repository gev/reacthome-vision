import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const k_blinds_gap = 0.2;
const k_blinds_width = 0.5;

class BlindsIconic extends Iconic {
  final double blindsGap;
  final double blindsWidth;

  final Path _path = Path();

  BlindsIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  }) : blindsGap = size * k_blinds_gap,
       blindsWidth = size * k_blinds_width {
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
