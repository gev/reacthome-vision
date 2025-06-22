import 'dart:ui';

abstract interface class Figure {
  void paint(Canvas canvas);
  bool hitTest(Offset position);
}

abstract interface class Disposable {
  void dispose();
}
