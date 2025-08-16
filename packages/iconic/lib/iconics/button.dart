import 'dart:ui';

import 'package:iconic/iconic.dart';

const kButtonSize = 0.5;

class ButtonIconic extends Iconic {
  final Path _path = Path();

  ButtonIconic({
    required super.offset,
    required super.size,
    required super.style,
  }) {
    _path
      ..moveTo(offset.dx - _buttonSize, offset.dy)
      ..relativeLineTo(realSize, 0)
      ..moveTo(offset.dx, offset.dy - _buttonSize)
      ..relativeLineTo(0, realSize)
      ..addRect(
        Rect.fromCenter(center: offset, width: realSize, height: realSize),
      );
  }
  double get _buttonSize => realSize * kButtonSize;

  @override
  double get weight => 0.8;

  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}
