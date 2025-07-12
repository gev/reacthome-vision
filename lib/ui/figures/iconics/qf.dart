import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const kQF = 0.3;

class QFIconic extends Iconic {
  final Path _path = Path();
  QFIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  }) {
    _path
      ..moveTo(offset.dx, offset.dy - halfSize)
      ..relativeLineTo(0, qf)
      ..relativeLineTo(qf, qf)
      ..moveTo(offset.dx, offset.dy + qf)
      ..relativeLineTo(0, qf);
  }

  double get qf => realSize * kQF;
  double get halfSize => realSize * 0.5;

  @override
  double get weight => 0.8;

  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}
