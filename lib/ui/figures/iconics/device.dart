import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const k_device_size = 0.5;
const k_circle_size = 0.6;

class DeviceIconic extends Iconic {
  final double device_size;
  final double circle_size;
  final Path _path = Path();

  DeviceIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  }) : device_size = size * k_device_size,
       circle_size = size * k_circle_size {
    _path
      ..addRect(Rect.fromCenter(center: offset, width: size, height: size))
      ..addOval(
        Rect.fromCenter(
          center: offset,
          width: circle_size,
          height: circle_size,
        ),
      );
  }
  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}
