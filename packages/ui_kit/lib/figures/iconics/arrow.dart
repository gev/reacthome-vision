import 'dart:ui';

import '../iconic.dart';

const kArrowLength = 0.5;

abstract class _ArrowIconic extends Iconic {
  final Path _path = Path();

  _ArrowIconic({
    required super.offset,
    required super.size,
    required super.style,
  });
  double get _arrowLength => realSize * kArrowLength;

  @override
  double get weight => 0.8;

  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}

class RightArrowIconic extends _ArrowIconic {
  RightArrowIconic({
    required super.offset,
    required super.size,
    required super.style,
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
    required super.style,
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
    required super.style,
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
    required super.style,
  }) {
    _path
      ..moveTo(offset.dx, offset.dy - _arrowLength)
      ..lineTo(offset.dx, offset.dy + _arrowLength)
      ..moveTo(offset.dx - _arrowLength, offset.dy)
      ..lineTo(offset.dx, offset.dy + _arrowLength)
      ..lineTo(offset.dx + _arrowLength, offset.dy);
  }
}
