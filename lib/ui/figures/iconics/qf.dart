import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const kQF = 0.3;

class QFIconic extends Iconic {
  final double qf;
  final double halfSize;
  final Path _path = Path();

  QFIconic({required super.offset, required super.size, required super.iconicStyle})
    : qf = size * kQF,
      halfSize = size * 0.5 {
    _path
      ..moveTo(offset.dx, offset.dy - halfSize)
      ..relativeLineTo(0, qf)
      ..relativeLineTo(qf, qf)
      ..moveTo(offset.dx, offset.dy + qf)
      ..relativeLineTo(0, qf);
  }
  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}
