import 'dart:ui';

abstract interface class Figure {
  void paint(Canvas canvas);
  bool hitTest(Offset position);
}

abstract interface class RelativeFigure {
  void paint(Canvas canvas, Offset offset);
  bool hitTest(Offset position, Offset offset);
}

abstract interface class Disposable {
  void dispose();
}
