import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const k_button_size = 0.5;

class ButtonIconic extends Iconic {
  final double buttonSize;
  ButtonIconic({required super.size, required super.iconicStyle})
    : buttonSize = size * k_button_size;
  @override
  void paint(Canvas canvas, Offset offset) {
    canvas.drawLine(
      Offset(offset.dx - buttonSize, offset.dy),
      Offset(offset.dx + buttonSize, offset.dy),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx - buttonSize, offset.dy - buttonSize),
      Offset(offset.dx + buttonSize, offset.dy - buttonSize),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx - buttonSize, offset.dy + buttonSize),
      Offset(offset.dx + buttonSize, offset.dy + buttonSize),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx - buttonSize, offset.dy - buttonSize),
      Offset(offset.dx - buttonSize, offset.dy + buttonSize),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx, offset.dy - buttonSize),
      Offset(offset.dx, offset.dy + buttonSize),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx + buttonSize, offset.dy - buttonSize),
      Offset(offset.dx + buttonSize, offset.dy + buttonSize),
      strokeStyle,
    );
  }
}
