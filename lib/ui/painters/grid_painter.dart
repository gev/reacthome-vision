import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:studio/ui/figures/label.dart';
import 'package:studio/ui_kit/theme/theme.dart';

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
  final double axisSize;
  final Paint axisStyle;
  final Paint pointStyle;
  final double gap;

  GridPainter({
    this.gap = 100,
    required this.controller,
    required ThemeContainer theme,
  }) : background = theme.backgroundColor,
       labelStyle = theme.bodyStyle.copyWith(color: theme.color.withAlpha(128)),
       axisSize = theme.bodyStyle.fontSize!,
       axisStyle = Paint()
         ..style = PaintingStyle.stroke
         ..color = theme.color.withAlpha(128),
       pointStyle = Paint()
         ..style = PaintingStyle.stroke
         ..strokeCap = StrokeCap.round
         ..color = theme.color.withAlpha(64),
       super(repaint: controller);

  @override
  void paint(Canvas canvas, Size size) {
    late int i;
    late double x, y, xmin, xmax, ymin, ymax;
    final ration = (1 / controller.scale).round();
    final step = ration > 1 ? ration : 1;
    final preScaled = gap * controller.scale;
    final scaled = preScaled * ration;

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

    void points() {
      final points = <Offset>[];
      for (double x = xmin + preScaled; x < xmax; x += preScaled) {
        for (double y = ymin + preScaled; y < ymax; y += preScaled) {
          if (x > axisSize + 4 && y > axisSize + 4) {
            points.add(Offset(x, y));
          }
        }
      }
      pointStyle.strokeWidth = 1 + controller.scale;
      canvas.drawPoints(PointMode.points, points, pointStyle);
    }

    void xAxis() {
      line(from: Offset(x, 0), to: Offset(x, axisSize));
      label(offset: Offset(x + 4, 4));
    }

    void yAxis() {
      line(from: Offset(0, y), to: Offset(axisSize, y));
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
    xmin = x;

    i = step;
    x = controller.offset.dx + scaled;
    while (x <= size.width) {
      xAxis();
      x += scaled;
      i += step;
    }
    xmax = x;

    i = 0;
    y = controller.offset.dy;
    while (y > 0) {
      yAxis();
      y -= scaled;
      i -= step;
    }
    ymin = y;

    i = step;
    y = controller.offset.dy + scaled;
    while (y < size.height) {
      yAxis();
      y += scaled;
      i += step;
    }
    ymax = y;

    points();
  }

  @override
  bool shouldRepaint(GridPainter oldDelegate) =>
      controller != oldDelegate.controller ||
      background != oldDelegate.background ||
      labelStyle != oldDelegate.labelStyle ||
      axisStyle != oldDelegate.axisStyle ||
      gap != oldDelegate.gap;
}
