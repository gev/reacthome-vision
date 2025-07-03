import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const k_shutter_length = 0.5;
const k_shutter_circle = 0.15;

abstract class ShutterIconic extends Iconic {
  final double shutterLength;
  final double shutterCircle;

  ShutterIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  }) : shutterLength = size * k_shutter_length,
       shutterCircle = size * k_shutter_circle;
}

class VerticalShutterIconic extends ShutterIconic {
  VerticalShutterIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  });
  @override
  void paint(Canvas canvas) {
    // canvas.drawLine(
    //   Offset(offset.dx - shutterLength, offset.dy - shutterLength),
    //   Offset(offset.dx + shutterLength, offset.dy + shutterLength),
    //   strokeStyle,
    // );
    // canvas.drawCircle(Offset(offset.dx, offset.dy), shutterCircle, strokeStyle);
  }
}

class HorizontalShutterIconic extends ShutterIconic {
  HorizontalShutterIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  });
  @override
  void paint(Canvas canvas) {
    // canvas.drawLine(
    //   Offset(offset.dx - shutterLength, offset.dy),
    //   Offset(offset.dx + shutterLength, offset.dy),
    //   strokeStyle,
    // );
    // canvas.drawCircle(Offset(offset.dx, offset.dy), shutterCircle, strokeStyle);
  }
}
