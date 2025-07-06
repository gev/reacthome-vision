import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const kMixerGap = 0.4;

class MixerIconic extends Iconic {
  final double mixerGap;
  final double halfSize;
  final Path _path = Path();

  MixerIconic({required super.offset, required super.size, required super.iconicStyle})
    : mixerGap = size * kMixerGap,
      halfSize = size * 0.5 {
    _path
      ..moveTo(offset.dx - mixerGap, offset.dy - halfSize)
      ..relativeLineTo(mixerGap, halfSize)
      ..relativeLineTo(0, halfSize)
      ..moveTo(offset.dx, offset.dy)
      ..relativeLineTo(mixerGap, -halfSize);
  }
  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}
