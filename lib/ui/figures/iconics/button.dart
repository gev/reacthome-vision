import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const k_button_size = 0.5;

class ButtonIconic extends Iconic {
  final Offset offset;
  final double buttonSize;
  final Path _path = Path();
  ButtonIconic({
    required this.offset,
    required super.size,
    required super.iconicStyle,
  }) : buttonSize = size * k_button_size {
    _path
      ..moveTo(offset.dx - buttonSize, offset.dy)
      ..relativeLineTo(size, 0)
      ..moveTo(offset.dx, offset.dy - buttonSize)
      ..relativeLineTo(0, size)
      ..addRect(Rect.fromCenter(center: offset, width: size, height: size));
  }
  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}
