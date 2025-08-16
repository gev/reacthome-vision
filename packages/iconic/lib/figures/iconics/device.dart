import 'dart:ui';

import 'package:iconic/figures/iconic.dart';

const kCircleSize = 0.7;

class DeviceIconic extends Iconic {
  final Path _path = Path();

  DeviceIconic({
    required super.offset,
    required super.size,
    required super.style,
  }) {
    _path
      ..addRect(
        Rect.fromCenter(center: offset, width: realSize, height: realSize),
      )
      ..addOval(
        Rect.fromCenter(center: offset, width: circleSize, height: circleSize),
      );
  }

  double get circleSize => realSize * kCircleSize;

  @override
  double get weight => 0.8;

  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}
