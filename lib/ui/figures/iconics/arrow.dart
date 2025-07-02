import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const k_arrow_length = 0.5;

abstract class _ArrowIconic extends Iconic {
  final Offset offset;
  final double _arrowLength;
  late final Offset _a, _b, _c, _d;
  _ArrowIconic({
    required this.offset,
    required super.size,
    required super.iconicStyle,
  }) : _arrowLength = size * k_arrow_length;

  @override
  void paint(Canvas canvas) {
    canvas.drawLine(_a, _b, strokeStyle);
    canvas.drawLine(_c, _b, strokeStyle);
    canvas.drawLine(_d, _b, strokeStyle);
  }
}

class RightArrowIconic extends _ArrowIconic {
  RightArrowIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  }) {
    _a = Offset(offset.dx - _arrowLength, offset.dy);
    _b = Offset(offset.dx + _arrowLength, offset.dy);
    _c = Offset(offset.dx, offset.dy - _arrowLength);
    _d = Offset(offset.dx, offset.dy + _arrowLength);
  }
}

class LeftArrowIconic extends _ArrowIconic {
  LeftArrowIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  }) {
    _a = Offset(offset.dx - _arrowLength, offset.dy);
    _b = Offset(offset.dx + _arrowLength, offset.dy);
    _c = Offset(offset.dx, offset.dy - _arrowLength);
    _d = Offset(offset.dx, offset.dy + _arrowLength);
  }
}

class TopArrowIconic extends _ArrowIconic {
  TopArrowIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  }) {
    _a = Offset(offset.dx - _arrowLength, offset.dy);
    _b = Offset(offset.dx + _arrowLength, offset.dy);
    _c = Offset(offset.dx, offset.dy - _arrowLength);
    _d = Offset(offset.dx, offset.dy + _arrowLength);
  }
}

class BottomArrowIconic extends _ArrowIconic {
  BottomArrowIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  }) {
    _a = Offset(offset.dx - _arrowLength, offset.dy);
    _b = Offset(offset.dx + _arrowLength, offset.dy);
    _c = Offset(offset.dx, offset.dy - _arrowLength);
    _d = Offset(offset.dx, offset.dy + _arrowLength);
  }
}
