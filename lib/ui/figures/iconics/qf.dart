import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const k_qf = 0.33;

class QFIconic extends Iconic {
  final double qfProportion;
  QFIconic({required super.size, required super.iconicStyle})
    : qfProportion = size * k_qf;
  @override
  void paint(Canvas canvas, Offset offset) {
    canvas.drawLine(
      Offset(offset.dx, offset.dy - qfProportion * 2),
      Offset(offset.dx, offset.dy - qfProportion),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx, offset.dy - qfProportion),
      Offset(offset.dx + qfProportion, offset.dy + qfProportion * 0.5),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx, offset.dy + qfProportion * 2),
      Offset(offset.dx, offset.dy + qfProportion),
      strokeStyle,
    );
  }
}
