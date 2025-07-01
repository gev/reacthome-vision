import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const k_bar_length = 0.6;
const k_bar_gap = 0.4;

class BarIconic extends Iconic {
  final double barGap;
  final double barLength;

  BarIconic({required super.size, required super.iconicStyle})
    : barGap = size * k_bar_gap,
      barLength = size * k_bar_length;

  @override
  void paint(Canvas canvas, Offset offset) {
    canvas.drawLine(
      Offset(offset.dx - barLength, offset.dy),
      Offset(offset.dx + barLength, offset.dy),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx - barLength, offset.dy - barGap),
      Offset(offset.dx + barLength, offset.dy - barGap),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx - barLength, offset.dy + barGap),
      Offset(offset.dx + barLength, offset.dy + barGap),
      strokeStyle,
    );
  }
}

class VerticalBarIconic extends Iconic {
  final double _size_gap;
  final double _size_length;
  VerticalBarIconic({required super.size, required super.iconicStyle})
    : _size_gap = size * k_bar_gap,
      _size_length = size * k_bar_length;

  @override
  void paint(Canvas canvas, Offset offset) {
    canvas.drawLine(
      Offset(offset.dx - _size_gap, offset.dy - _size_length),
      Offset(offset.dx - _size_gap, offset.dy + _size_length),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx, offset.dy - _size_length),
      Offset(offset.dx, offset.dy + _size_length),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx + _size_gap, offset.dy - _size_length),
      Offset(offset.dx + _size_gap, offset.dy + _size_length),
      strokeStyle,
    );
  }
}
