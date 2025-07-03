import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const k_button_size = 0.5;

class ButtonIconic extends Iconic {
  final double _buttonSize;
  final Path _path = Path();

  ButtonIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  }) : _buttonSize = size * k_button_size {
    _path
      ..moveTo(offset.dx - _buttonSize, offset.dy)
      ..relativeLineTo(size, 0)
      ..moveTo(offset.dx, offset.dy - _buttonSize)
      ..relativeLineTo(0, size)
      ..addRect(Rect.fromCenter(center: offset, width: size, height: size));
  }
  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}
