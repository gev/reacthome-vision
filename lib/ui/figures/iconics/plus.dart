import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const k_plus_size = 0.5;

class PlusIconic extends Iconic {
  final double plusSize;
  PlusIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  }) : plusSize = size * k_plus_size;
  @override
  void paint(Canvas canvas) {
    // canvas.drawLine(
    //   Offset(offset.dx - plusSize, offset.dy),
    //   Offset(offset.dx + plusSize, offset.dy),
    //   strokeStyle,
    // );
    // canvas.drawLine(
    //   Offset(offset.dx, offset.dy - plusSize),
    //   Offset(offset.dx, offset.dy + plusSize),
    //   strokeStyle,
    // );
  }
}
