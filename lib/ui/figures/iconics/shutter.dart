import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const k_shutter_length = 0.5;
const k_shutter_circle = 0.15;

class ShutterIconic extends Iconic {
  final double shutterLength;
  final double shutterCircle;
  ShutterIconic({required super.size, required super.iconicStyle})
    : shutterLength = size * k_shutter_length,
      shutterCircle = size * k_shutter_circle;
  @override
  void paint(Canvas canvas, Offset offset) {
    canvas.drawLine(
      Offset(offset.dx - shutterLength, offset.dy - shutterLength),
      Offset(offset.dx + shutterLength, offset.dy + shutterLength),
      strokeStyle,
    );
    canvas.drawCircle(Offset(offset.dx, offset.dy), shutterCircle, strokeStyle);
  }
}

class HorizontalShutterIconic extends Iconic {
  final double shutterLength;
  final double shutterCircle;
  HorizontalShutterIconic({required super.size, required super.iconicStyle})
    : shutterLength = size * k_shutter_length,
      shutterCircle = size * k_shutter_circle;
  @override
  void paint(Canvas canvas, Offset offset) {
    canvas.drawLine(
      Offset(offset.dx - shutterLength, offset.dy),
      Offset(offset.dx + shutterLength, offset.dy),
      strokeStyle,
    );
    canvas.drawCircle(Offset(offset.dx, offset.dy), shutterCircle, strokeStyle);
  }
}
