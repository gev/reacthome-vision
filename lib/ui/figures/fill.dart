import 'dart:ui';

import 'package:studio/ui/figures/figure.dart';

class Fill implements Figure {
  final Color color;
  final BlendMode blendMode;

  const Fill({required this.color, this.blendMode = BlendMode.src});

  @override
  void paint(Canvas canvas) => canvas.drawColor(color, blendMode);

  @override
  bool hitTest(Offset position) => false;
}
