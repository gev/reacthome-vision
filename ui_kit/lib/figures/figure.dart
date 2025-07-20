import 'dart:ui';

abstract interface class Paintable {
  void paint(Canvas canvas);
}

abstract interface class Hittable {
  bool hitTest(Offset position);
}

abstract interface class PaintableAt {
  void paint(Canvas canvas, Offset offset);
}

abstract interface class HittableAt {
  bool hitTest(Offset position, Offset offset);
}

abstract interface class Disposable {
  void dispose();
}
