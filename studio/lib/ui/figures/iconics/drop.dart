import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const kDropStart = 0.5;
const kDropWidth1 = 0.45;
const kDropHeight1 = 0.45;
const kDropWidth2 = 0.45;

class DropIconic extends Iconic {
  final Path _path = Path();

  DropIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  }) {
    _path.moveTo(offset.dx, offset.dy - dropStart);
    _path.relativeCubicTo(
      -dropWidth1,
      dropHeight1,
      -dropWidth2,
      realSize,
      0,
      realSize,
    );
    _path.moveTo(offset.dx, offset.dy - dropStart);
    _path.relativeCubicTo(
      dropWidth1,
      dropHeight1,
      dropWidth2,
      realSize,
      0,
      realSize,
    );
  }

  double get dropStart => realSize * kDropStart;
  double get dropWidth1 => realSize * kDropWidth1;
  double get dropHeight1 => realSize * kDropHeight1;
  double get dropWidth2 => realSize * kDropWidth2;

  @override
  double get weight => 0.75;

  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}
