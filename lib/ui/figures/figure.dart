import 'dart:ui';

abstract interface class Paintable {
  void paint(Canvas canvas);
  bool hitTest(Offset position);
}

abstract interface class PaintableAt {
  void paint(Canvas canvas, Offset offset);
  bool hitTest(Offset position, Offset offset);
}

abstract interface class Disposable {
  void dispose();
}
