import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const kArrowLength = 0.5;

abstract class _ArrowIconic extends Iconic {
  final Offset offset;
  final double _arrowLength;

  final Path _path = Path();

  _ArrowIconic({
    required this.offset,
    required super.size,
    required super.iconicStyle,
  }) : _arrowLength = size * kArrowLength;
  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}

class RightArrowIconic extends _ArrowIconic {
  RightArrowIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  }) {
    _path
      ..moveTo(offset.dx - _arrowLength, offset.dy)
      ..lineTo(offset.dx + _arrowLength, offset.dy)
      ..moveTo(offset.dx, offset.dy - _arrowLength)
      ..lineTo(offset.dx + _arrowLength, offset.dy)
      ..lineTo(offset.dx, offset.dy + _arrowLength);
  }
}

class LeftArrowIconic extends _ArrowIconic {
  LeftArrowIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  }) {
    _path
      ..moveTo(offset.dx + _arrowLength, offset.dy)
      ..lineTo(offset.dx - _arrowLength, offset.dy)
      ..moveTo(offset.dx, offset.dy - _arrowLength)
      ..lineTo(offset.dx - _arrowLength, offset.dy)
      ..lineTo(offset.dx, offset.dy + _arrowLength);
  }
}

class TopArrowIconic extends _ArrowIconic {
  TopArrowIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  }) {
    _path
      ..moveTo(offset.dx, offset.dy + _arrowLength)
      ..lineTo(offset.dx, offset.dy - _arrowLength)
      ..moveTo(offset.dx - _arrowLength, offset.dy)
      ..lineTo(offset.dx, offset.dy - _arrowLength)
      ..lineTo(offset.dx + _arrowLength, offset.dy);
  }
}

class BottomArrowIconic extends _ArrowIconic {
  BottomArrowIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  }) {
    _path
      ..moveTo(offset.dx, offset.dy - _arrowLength)
      ..lineTo(offset.dx, offset.dy + _arrowLength)
      ..moveTo(offset.dx - _arrowLength, offset.dy)
      ..lineTo(offset.dx, offset.dy + _arrowLength)
      ..lineTo(offset.dx + _arrowLength, offset.dy);
  }
}
