import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const k2 = 0.5;
const k_blinds_gap = 0.5;
const k_blinds_width = 1.2;

class BlindsIconic extends Iconic {
  final double _size_2;
  final double _size_gap;
  BlindsIconic({required super.size, required super.iconicStyle})
    : _size_2 = size * k2,
      _size_gap = size * k_blinds_gap;
  @override
  void paint(Canvas canvas, Offset offset) {
    canvas.drawLine(
      Offset(offset.dx - _size_2 * k_blinds_width, offset.dy),
      Offset(offset.dx + _size_2 * k_blinds_width, offset.dy),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(
        offset.dx - _size_2 * k_blinds_width,
        offset.dy - _size_2 * k_blinds_gap,
      ),
      Offset(
        offset.dx + _size_2 * k_blinds_width,
        offset.dy - _size_2 * k_blinds_gap,
      ),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx - _size_2 * k_blinds_width, offset.dy - _size_2),
      Offset(offset.dx + _size_2 * k_blinds_width, offset.dy - _size_2),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(
        offset.dx - _size_2 * k_blinds_width,
        offset.dy + _size_2 * k_blinds_gap,
      ),
      Offset(
        offset.dx + _size_2 * k_blinds_width,
        offset.dy + _size_2 * k_blinds_gap,
      ),
      strokeStyle,
    );
    canvas.drawLine(
      Offset(offset.dx - _size_2 * k_blinds_width, offset.dy + _size_2),
      Offset(offset.dx + _size_2 * k_blinds_width, offset.dy + _size_2),
      strokeStyle,
    );
  }
}
