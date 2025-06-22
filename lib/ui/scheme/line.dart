import 'package:flutter/widgets.dart' hide Element;
import 'package:studio/ui/figures/figure.dart';
import 'package:studio/ui/scheme/node.dart';
import 'package:studio/ui_kit/theme/theme.dart';

class Line<Id> implements Figure {
  Line({
    required this.id,
    required this.start,
    required this.end,
    required ThemeContainer theme,
  }) : style = Paint()
         ..style = PaintingStyle.stroke
         ..color = theme.bodyStyle.color!
         ..strokeWidth = 1;

  final Id id;
  final Node start;
  final Node end;
  final Paint style;

  @override
  void paint(Canvas canvas) {
    canvas.drawLine(start.center, end.center, style);
  }

  @override
  bool hitTest(Offset position) {
    // Implement hit test logic for the line
    return false;
  }
}
