import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const k_shutter_length = 0.4;
const k_shutter_circle = 0.15;

abstract class ShutterIconic extends Iconic {
  final double shutterLength;
  final double shutterCircle;
  final Path _path = Path();

  ShutterIconic({required super.offset, required super.size, required super.iconicStyle})
    : shutterLength = size * k_shutter_length,
      shutterCircle = size * k_shutter_circle;

  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}

class VerticalShutterIconic extends ShutterIconic {
  VerticalShutterIconic({required super.offset, required super.size, required super.iconicStyle}) {
    _path
      ..moveTo(offset.dx - shutterLength, offset.dy - shutterLength)
      ..relativeLineTo(2 * shutterLength, 2 * shutterLength)
      ..addOval(Rect.fromCircle(center: offset, radius: shutterCircle));
  }
}

class HorizontalShutterIconic extends ShutterIconic {
  HorizontalShutterIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  }) {
    _path
      ..moveTo(offset.dx - size / 2, offset.dy)
      ..relativeLineTo(size, 0)
      ..addOval(Rect.fromCircle(center: offset, radius: shutterCircle));
  }
}
