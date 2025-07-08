import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const kDeviceSize = 0.5;
const kCircleSize = 0.6;

class DeviceIconic extends Iconic {
  final double deviceSize;
  final double circleSize;
  final Path _path = Path();

  DeviceIconic({required super.offset, required super.size, required super.iconicStyle})
    : deviceSize = size * kDeviceSize,
      circleSize = size * kCircleSize {
    _path
      ..addRect(Rect.fromCenter(center: offset, width: size, height: size))
      ..addOval(Rect.fromCenter(center: offset, width: circleSize, height: circleSize));
  }
  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}
