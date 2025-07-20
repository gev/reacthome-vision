import 'dart:math';
import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const kShutterCircle = 0.1;

abstract class ShutterIconic extends Iconic {
  final Path _path = Path();

  ShutterIconic({
    required super.offset,
    required super.size,
    required double phi,
    required super.iconicStyle,
  }) {
    final dx = realSize * cos(-phi) / 2;
    final dy = realSize * sin(-phi) / 2;
    _path
      ..moveTo(offset.dx + dx, offset.dy + dy)
      ..lineTo(offset.dx - dx, offset.dy - dy)
      ..addOval(
        Rect.fromCircle(center: offset, radius: realSize * kShutterCircle),
      );
  }

  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}

class HorizontalShutterIconic extends ShutterIconic {
  HorizontalShutterIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  }) : super(phi: 0);
}

class VerticalShutterIconic extends ShutterIconic {
  VerticalShutterIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  }) : super(phi: pi / 2);
}

class DiagonalShutterIconic extends ShutterIconic {
  DiagonalShutterIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  }) : super(phi: pi / 4);
}

class BackDiagonalShutterIconic extends ShutterIconic {
  BackDiagonalShutterIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  }) : super(phi: 3 * pi / 4);
}
