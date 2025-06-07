import 'package:flutter/widgets.dart';
import 'package:studio/ui/figures/label.dart';

class GridPainter extends CustomPainter {
  final Offset offset;
  final double scale;
  late final Color background;
  final TextStyle labelStyle;
  final Paint axisStyle;
  final double gap;

  late final double _gap;
  late final int _step;

  GridPainter({
    required this.background,
    required this.labelStyle,
    required this.axisStyle,
    this.gap = 100,
    required this.offset,
    required this.scale,
  }) {
    final scaled = gap * scale;
    final ration = (100 / scaled).round();
    _step = ration > 1 ? ration : 1;
    _gap = scaled * ration;
  }

  @override
  void paint(Canvas canvas, Size size) {
    late int i;
    late double x, y;

    void line({required Offset from, required Offset to}) {
      canvas.drawLine(from, to, axisStyle);
    }

    void label({required Offset offset}) {
      final label = Label(
        text: i.toString(),
        maxWidth: _gap - 8,
        offset: offset,
        style: labelStyle,
      );
      label.paint(canvas);
      label.dispose();
    }

    void xAxis() {
      line(from: Offset(x, 0), to: Offset(x, size.height));
      label(offset: Offset(x + 4, 4));
    }

    void yAxis() {
      line(from: Offset(0, y), to: Offset(size.width, y));
      label(offset: Offset(4, y + 4));
    }

    canvas.drawColor(background, BlendMode.src);

    i = 0;
    x = offset.dx;
    while (x >= 0) {
      xAxis();
      x -= _gap;
      i -= _step;
    }

    i = _step;
    x = offset.dx + _gap;
    while (x <= size.width) {
      xAxis();
      x += _gap;
      i += _step;
    }

    i = 0;
    y = offset.dy;
    while (y > 0) {
      yAxis();
      y -= _gap;
      i -= _step;
    }

    i = _step;
    y = offset.dy + _gap;
    while (y < size.height) {
      yAxis();
      y += _gap;
      i += _step;
    }
  }

  @override
  bool shouldRepaint(GridPainter oldDelegate) =>
      offset != oldDelegate.offset ||
      scale != oldDelegate.scale ||
      background != oldDelegate.background ||
      labelStyle != oldDelegate.labelStyle ||
      axisStyle != oldDelegate.axisStyle ||
      gap != oldDelegate.gap;
}
