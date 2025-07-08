import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const kMixerGap = 0.4;

abstract class MixerIconic extends Iconic {
  final double mixerGap;
  final double halfSize;
  final Path _path = Path();

  MixerIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  }) : mixerGap = size * kMixerGap,
       halfSize = size * 0.5;
  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}

class DownMixerIconic extends MixerIconic {
  DownMixerIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  }) {
    _path
      ..moveTo(offset.dx - mixerGap, offset.dy + halfSize)
      ..relativeLineTo(mixerGap, -halfSize)
      ..relativeLineTo(0, -halfSize)
      ..moveTo(offset.dx, offset.dy)
      ..relativeLineTo(mixerGap, halfSize);
  }
}

class UpMixerIconic extends MixerIconic {
  UpMixerIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  }) {
    _path
      ..moveTo(offset.dx - mixerGap, offset.dy + halfSize)
      ..relativeLineTo(mixerGap, -halfSize)
      ..relativeLineTo(0, -halfSize)
      ..moveTo(offset.dx, offset.dy)
      ..relativeLineTo(mixerGap, halfSize);
  }
}

class RightMixerIconic extends MixerIconic {
  RightMixerIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  }) {
    _path
      ..moveTo(offset.dx - halfSize, offset.dy + mixerGap)
      ..relativeLineTo(halfSize, -mixerGap)
      ..relativeLineTo(halfSize, 0)
      ..moveTo(offset.dx, offset.dy)
      ..relativeLineTo(-halfSize, -mixerGap);
  }
}

class LeftMixerIconic extends MixerIconic {
  LeftMixerIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  }) {
    _path
      ..moveTo(offset.dx + halfSize, offset.dy + mixerGap)
      ..relativeLineTo(-halfSize, -mixerGap)
      ..relativeLineTo(-halfSize, 0)
      ..moveTo(offset.dx, offset.dy)
      ..relativeLineTo(halfSize, -mixerGap);
  }
}
