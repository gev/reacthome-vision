import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const k_device_size = 0.5;
const k_circle_size = 0.35;

class DeviceIconic extends Iconic {
  final double device_size;
  final double circle_size;
  DeviceIconic({required super.size, required super.iconicStyle})
    : device_size = size * k_device_size,
      circle_size = size * k_circle_size;
  @override
  void paint(Canvas canvas) {
    // canvas.drawRect(
    //   Rect.fromPoints(
    //     Offset(offset.dx - device_size, offset.dy + device_size),
    //     Offset(offset.dx + device_size, offset.dy - device_size),
    //   ),
    //   strokeStyle,
    // );
    // canvas.drawCircle(Offset(offset.dx, offset.dy), circle_size, strokeStyle);
  }
}
