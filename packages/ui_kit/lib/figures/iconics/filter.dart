import 'dart:ui';

import '../iconic.dart';

const kSideLine = 1;
const kLines = 0.8;
const kArcRadius = kSideLine / 6;

abstract class FilterIconic extends Iconic {
  FilterIconic({
    required super.offset,
    required super.size,
    required super.style,
  });

  double get sideLine => realSize * kSideLine;
  double get lines => realSize * kLines;
  double get arcRadius => realSize * kArcRadius;

  final Path _path = Path();

  @override
  double get weight => 0.75;

  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, strokeStyle);
  }
}

class RightFilterIconic extends FilterIconic {
  RightFilterIconic({
    required super.offset,
    required super.size,
    required super.style,
  }) {
    _path
      ..moveTo(offset.dx - lines / 2, offset.dy - sideLine / 2)
      ..relativeLineTo(0, sideLine)
      ..relativeLineTo(lines - arcRadius, 0)
      ..relativeArcToPoint(
        Offset(0, -arcRadius * 2),
        radius: Radius.circular(arcRadius),
        clockwise: false,
      )
      ..relativeLineTo(-(lines - arcRadius), 0)
      ..relativeMoveTo(0, -sideLine / 3)
      ..relativeLineTo(lines - arcRadius, 0)
      ..relativeArcToPoint(
        Offset(0, -arcRadius * 2),
        radius: Radius.circular(arcRadius),
        clockwise: false,
      )
      ..relativeLineTo(-(lines - arcRadius), 0)
      ..close();
  }
}

class LeftFilterIconic extends FilterIconic {
  LeftFilterIconic({
    required super.offset,
    required super.size,
    required super.style,
  }) {
    _path
      ..moveTo(offset.dx + lines / 2, offset.dy - sideLine / 2)
      ..relativeLineTo(0, sideLine)
      ..relativeLineTo(-(lines - arcRadius), 0)
      ..relativeArcToPoint(
        Offset(0, -arcRadius * 2),
        radius: Radius.circular(arcRadius),
        clockwise: true,
      )
      ..relativeLineTo(lines - arcRadius, 0)
      ..relativeMoveTo(0, -sideLine / 3)
      ..relativeLineTo(-(lines - arcRadius), 0)
      ..relativeArcToPoint(
        Offset(0, -arcRadius * 2),
        radius: Radius.circular(arcRadius),
        clockwise: true,
      )
      ..relativeLineTo(lines - arcRadius, 0)
      ..close();
  }
}

class DownFilterIconic extends FilterIconic {
  DownFilterIconic({
    required super.offset,
    required super.size,
    required super.style,
  }) {
    _path
      ..moveTo(offset.dx - sideLine / 2, offset.dy - lines / 2)
      ..relativeLineTo(sideLine, 0)
      ..relativeLineTo(0, lines - arcRadius)
      ..relativeArcToPoint(
        Offset(-arcRadius * 2, 0),
        radius: Radius.circular(arcRadius),
        clockwise: true,
      )
      ..relativeLineTo(0, -(lines - arcRadius))
      ..relativeMoveTo(-sideLine / 3, 0)
      ..relativeLineTo(0, lines - arcRadius)
      ..relativeArcToPoint(
        Offset(-arcRadius * 2, 0),
        radius: Radius.circular(arcRadius),
        clockwise: true,
      )
      ..relativeLineTo(0, -(lines - arcRadius))
      ..close();
  }
}

class UpFilterIconic extends FilterIconic {
  UpFilterIconic({
    required super.offset,
    required super.size,
    required super.style,
  }) {
    _path
      ..moveTo(offset.dx - sideLine / 2, offset.dy + lines / 2)
      ..relativeLineTo(sideLine, 0)
      ..relativeLineTo(0, -(lines - arcRadius))
      ..relativeArcToPoint(
        Offset(-arcRadius * 2, 0),
        radius: Radius.circular(arcRadius),
        clockwise: false,
      )
      ..relativeLineTo(0, lines - arcRadius)
      ..relativeMoveTo(-sideLine / 3, 0)
      ..relativeLineTo(0, -(lines - arcRadius))
      ..relativeArcToPoint(
        Offset(-arcRadius * 2, 0),
        radius: Radius.circular(arcRadius),
        clockwise: false,
      )
      ..relativeLineTo(0, lines - arcRadius)
      ..close();
  }
}
