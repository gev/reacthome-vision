import 'dart:ui';

import 'package:iconic/figures/iconic.dart';

const kTrackLength = 0.8;
const kTrackHeight = 0.2;

class TrackIconic extends Iconic {
  final Path _path = Path();

  TrackIconic({
    required super.offset,
    required super.size,
    required super.style,
  }) {
    _path
      ..moveTo(offset.dx - trackLength / 2, offset.dy - trackHeight)
      ..relativeLineTo(trackLength, 0)
      ..relativeArcToPoint(
        Offset(0, trackHeight * 2),
        radius: Radius.circular(trackHeight),
        clockwise: true,
      )
      ..relativeLineTo(-trackLength, 0)
      ..relativeArcToPoint(
        Offset(0, -trackHeight * 2),
        radius: Radius.circular(trackHeight),
        clockwise: true,
      )
      ..moveTo(offset.dx - trackLength / 4, offset.dy - trackHeight)
      ..relativeLineTo(0, trackHeight * 2)
      ..moveTo(offset.dx + trackLength / 4, offset.dy - trackHeight)
      ..relativeLineTo(0, trackHeight * 2);
  }

  double get trackLength => realSize * kTrackLength;
  double get trackHeight => realSize * kTrackHeight;

  @override
  double get weight => 0.8;

  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}
