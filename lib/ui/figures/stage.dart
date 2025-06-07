import 'dart:ui';

import 'package:studio/ui/figures/figure.dart';

class Stage implements DisposableFigure {
  final List<Figure> figures;

  Stage({required this.figures});

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
      if (figure case DisposableFigure f) f.dispose();
    }
  }
}
