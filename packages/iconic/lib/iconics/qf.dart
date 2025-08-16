import 'dart:ui';

import 'package:iconic/iconic.dart';

const kQF = 0.28;

class QFIconic extends Iconic {
  final Path _path = Path();
  QFIconic({required super.offset, required super.size, required super.style}) {
    _path
      ..moveTo(offset.dx, offset.dy - halfSize)
      ..relativeLineTo(0, qf)
      ..relativeLineTo(qf, qf)
      ..moveTo(offset.dx, offset.dy + halfSize)
      ..relativeLineTo(0, -qf);
  }

  double get qf => realSize * kQF;
  double get halfSize => realSize * 0.5;

  @override
  double get weight => 0.9;

  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}
