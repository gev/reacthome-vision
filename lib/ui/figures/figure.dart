import 'dart:ui';

abstract interface class Figure {
  void paint(Canvas canvas);
  bool hitTest(Offset position);
}

abstract interface class Disposable {
  void dispose();
}

Paint paintStyle({PaintingStyle? style, Color? color, double? strokeWidth}) {
  final paint = Paint();

  if (style != null) paint.style = style;
  if (color != null) paint.color = color;
  if (strokeWidth != null) paint.strokeWidth = strokeWidth;

  return paint;
}
