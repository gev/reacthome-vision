import 'dart:ui';

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
  final GridStyle style;
  final double gap;

  GridPainter({this.gap = 100, required this.controller, required this.style})
    : super(repaint: controller);

  @override
  void paint(Canvas canvas, Size size) {
    late int i;
    late double x, y, xmin, xmax, ymin, ymax;
    final ration = (1 / controller.scale).round();
    final step = ration > 1 ? ration : 1;
    final preScaled = gap * controller.scale;
    final scaled = preScaled * ration;

    void line({required Offset from, required Offset to}) {
      canvas.drawLine(from, to, style.axisStyle);
    }

    void label({required Offset offset}) {
      final label = Label(
        text: i.toString(),
        maxWidth: scaled - 8,
        style: style.labelStyle,
      );
      label.paint(canvas, offset);
      label.dispose();
    }

    void points() {
      final points = <Offset>[];
      for (double x = xmin + preScaled; x < xmax; x += preScaled) {
        for (double y = ymin + preScaled; y < ymax; y += preScaled) {
          if (x > style.axisLength + 4 && y > style.axisLength + 4) {
            points.add(Offset(x, y));
          }
        }
      }
      style.pointStyle.strokeWidth = 1 + controller.scale;
      canvas.drawPoints(PointMode.points, points, style.pointStyle);
    }

    void xAxis() {
      line(from: Offset(x, 0), to: Offset(x, style.axisLength));
      label(offset: Offset(x + 4, 4));
    }

    void yAxis() {
      line(from: Offset(0, y), to: Offset(style.axisLength, y));
      label(offset: Offset(4, y + 4));
    }

    canvas.drawColor(style.backgroundColor, BlendMode.src);

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
      style != oldDelegate.style ||
      gap != oldDelegate.gap;
}

class GridStyle {
  final Color backgroundColor;
  final TextStyle labelStyle;
  final double axisLength;
  final double axisStrokeWidth;

  final Paint axisStyle;
  final Paint pointStyle;

  GridStyle({
    required this.backgroundColor,
    required this.labelStyle,
    required this.axisStrokeWidth,
  }) : axisLength = labelStyle.fontSize!,
       axisStyle = Paint()
         ..style = PaintingStyle.stroke
         ..color = labelStyle.color!.withAlpha(128),
       pointStyle = Paint()
         ..style = PaintingStyle.stroke
         ..strokeCap = StrokeCap.round
         ..color = labelStyle.color!.withAlpha(64);
}
