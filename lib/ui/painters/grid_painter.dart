import 'package:flutter/widgets.dart';
import 'package:studio/ui/figures/label.dart';

class GridController with ChangeNotifier {
  Offset _offset = const Offset(0, 0);
  double _scale = 1;

  Offset get offset => _offset;
  double get scale => _scale;

  void update(Offset offset, double scale) {
    if (_offset != offset || _scale != scale) {
      _offset = offset;
      _scale = scale;
      notifyListeners();
    }
  }
}

class GridPainter extends CustomPainter {
  final GridController controller;
  late final Color background;
  final TextStyle labelStyle;
  final Paint axisStyle;
  final double gap;

  GridPainter({
    required this.background,
    required this.labelStyle,
    required this.axisStyle,
    this.gap = 100,
    required this.controller,
  }) : super(repaint: controller);

  @override
  void paint(Canvas canvas, Size size) {
    late int i;
    late double x, y;
    final ration = (1 / controller.scale).round();
    final step = ration > 1 ? ration : 1;
    final scaled = gap * controller.scale * ration;

    void line({required Offset from, required Offset to}) {
      canvas.drawLine(from, to, axisStyle);
    }

    void label({required Offset offset}) {
      final label = Label(
        text: i.toString(),
        maxWidth: scaled - 8,
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
    x = controller.offset.dx;
    while (x >= 0) {
      xAxis();
      x -= scaled;
      i -= step;
    }

    i = step;
    x = controller.offset.dx + scaled;
    while (x <= size.width) {
      xAxis();
      x += scaled;
      i += step;
    }

    i = 0;
    y = controller.offset.dy;
    while (y > 0) {
      yAxis();
      y -= scaled;
      i -= step;
    }

    i = step;
    y = controller.offset.dy + scaled;
    while (y < size.height) {
      yAxis();
      y += scaled;
      i += step;
    }
  }

  @override
  bool shouldRepaint(GridPainter oldDelegate) =>
      controller != oldDelegate.controller ||
      background != oldDelegate.background ||
      labelStyle != oldDelegate.labelStyle ||
      axisStyle != oldDelegate.axisStyle ||
      gap != oldDelegate.gap;
}
