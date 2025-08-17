import 'dart:ui';

import 'package:iconic/iconic.dart';

const kMixerGap = 0.35;
const kkYSize = 0.4;
const kStemSize = 0.45;
const kCenter = 0;

abstract class MixerIconic extends Iconic {
  final Path _path = Path();

  MixerIconic({
    required super.offset,
    required super.size,
    required super.style,
  });

  double get mixerGap => realSize * kMixerGap;
  double get ySize => realSize * kkYSize;
  double get stemSize => realSize * kStemSize;
  double get center => realSize * kCenter;

  @override
  double get weight => 0.8;

  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, stroke);
  }
}

class DownMixerIconic extends MixerIconic {
  DownMixerIconic({
    required super.offset,
    required super.size,
    required super.style,
  }) {
    _path
      ..moveTo(offset.dx, offset.dy + center)
      ..relativeLineTo(-mixerGap, -ySize)
      ..relativeMoveTo(mixerGap, ySize)
      ..relativeLineTo(0, stemSize)
      ..relativeMoveTo(0, -stemSize)
      ..relativeLineTo(mixerGap, -ySize);
  }
}

class UpMixerIconic extends MixerIconic {
  UpMixerIconic({
    required super.offset,
    required super.size,
    required super.style,
  }) {
    _path
      ..moveTo(offset.dx, offset.dy - center)
      ..relativeLineTo(-mixerGap, ySize)
      ..relativeMoveTo(mixerGap, -ySize)
      ..relativeLineTo(0, -stemSize)
      ..relativeMoveTo(0, stemSize)
      ..relativeLineTo(mixerGap, ySize);
  }
}

class LeftMixerIconic extends MixerIconic {
  LeftMixerIconic({
    required super.offset,
    required super.size,
    required super.style,
  }) {
    _path
      ..moveTo(offset.dx - center, offset.dy)
      ..relativeLineTo(-stemSize, 0)
      ..relativeMoveTo(stemSize, 0)
      ..relativeLineTo(ySize, -mixerGap)
      ..relativeMoveTo(-ySize, mixerGap)
      ..relativeLineTo(ySize, mixerGap);
  }
}

class RightMixerIconic extends MixerIconic {
  RightMixerIconic({
    required super.offset,
    required super.size,
    required super.style,
  }) {
    _path
      ..moveTo(offset.dx + center, offset.dy)
      ..relativeLineTo(stemSize, 0)
      ..relativeMoveTo(-stemSize, 0)
      ..relativeLineTo(-ySize, -mixerGap)
      ..relativeMoveTo(ySize, mixerGap)
      ..relativeLineTo(-ySize, mixerGap);
  }
}
