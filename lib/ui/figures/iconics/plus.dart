import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const k_plus_size = 0.5;

class PlusIconic extends Iconic {
  final double plusSize;
  final Path _path = Path();
  PlusIconic({required super.offset, required super.size, required super.iconicStyle})
    : plusSize = size * k_plus_size {
    _path
      ..moveTo(offset.dx - plusSize, offset.dy)
      ..lineTo(offset.dx + plusSize, offset.dy)
      ..moveTo(offset.dx, offset.dy - plusSize)
      ..lineTo(offset.dx, offset.dy + plusSize);
  }
  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}
