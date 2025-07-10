import 'dart:ui';

import 'package:studio/ui/figures/iconic.dart';

const kDeviceSize = 0.5;
const kCircleSize = 0.6;

class DeviceIconic extends Iconic {
  final Path _path = Path();

  DeviceIconic({
    required super.offset,
    required super.size,
    required super.iconicStyle,
  }) {
    _path
      ..addRect(Rect.fromCenter(center: offset, width: deviceSize, height: deviceSize))
      ..addOval(
        Rect.fromCenter(center: offset, width: circleSize, height: circleSize),
      );
  }

  double get deviceSize => realSize * kDeviceSize;
  double get circleSize => realSize * kCircleSize;

  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}
