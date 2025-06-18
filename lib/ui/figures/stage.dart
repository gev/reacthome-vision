import 'dart:ui';

import 'package:studio/ui/figures/figure.dart';

class Stage implements Figure, Disposable {
  Stage({required this.figures});

  final List<Figure> figures;

  @override
  void paint(Canvas canvas) {
    for (final figure in figures) {
      figure.paint(canvas);
    }
  }

  @override
  bool hitTest(Offset position) {
    for (final figure in figures) {
      if (figure.hitTest(position)) {
        return true;
      }
    }
    return false;
  }

  @override
  void dispose() {
    for (final figure in figures) {
      if (figure case Disposable it) it.dispose();
    }
  }
}
