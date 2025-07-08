import 'dart:ui';

import 'package:studio/ui/figures/figure.dart';

enum Direction { left, up, right, down, any }

typedef Anchor = ({Direction direction, Offset offset});

class Line implements Paintable {
  final Anchor start;
  final Anchor end;
  final double radius;
  final LineStyle style;

  final Path _path = Path();

  Line({
    this.radius = 24,
    required this.start,
    required this.end,
    required this.style,
  }) {
    _path.moveTo(start.offset.dx, start.offset.dy);
    switch (start.direction) {
      case Direction.left:
        _l();
      case Direction.up:
        _u();
      case Direction.right:
        _r();
      case Direction.down:
        _d();
      case Direction.any:
        _a();
    }
    _path.lineTo(end.offset.dx, end.offset.dy);
  }

  void _l() {
    switch (end.direction) {
      case Direction.left:
        _ll();
      case Direction.up:
        _lu();
      case Direction.right:
        _lr();
      case Direction.down:
        _ld();
      case Direction.any:
        _la();
    }
  }

  void _u() {
    switch (end.direction) {
      case Direction.left:
        _ul();
      case Direction.up:
        _uu();
      case Direction.right:
        _ur();
      case Direction.down:
        _ud();
      case Direction.any:
        _ua();
    }
  }

  void _r() {
    switch (end.direction) {
      case Direction.left:
        _rl();
      case Direction.up:
        _ru();
      case Direction.right:
        _rr();
      case Direction.down:
        _rd();
      case Direction.any:
        _ra();
    }
  }

  void _d() {
    switch (end.direction) {
      case Direction.left:
        _dl();
      case Direction.up:
        _du();
      case Direction.right:
        _dr();
      case Direction.down:
        _dd();
      case Direction.any:
        _da();
    }
  }

  void _a() {
    switch (end.direction) {
      case Direction.left:
        _al();
      case Direction.up:
        _au();
      case Direction.right:
        _ar();
      case Direction.down:
        _ad();
      case Direction.any:
        _aa();
    }
  }

  void _ll() {
    _path.relativeLineTo(-radius, 0);
    if (end.offset.dx < start.offset.dx) {
    } else {
      if (end.offset.dy < start.offset.dy) {
        final dy = start.offset.dy - end.offset.dy;
        _path.relativeArcToPoint(
          Offset(-radius, -radius),
          radius: Radius.circular(radius),
        );
        if (dy > 2 * radius) {
          _path.relativeLineTo(0, 2 * radius - dy);
          _path.relativeArcToPoint(
            Offset(radius, -radius),
            radius: Radius.circular(radius),
          );
        } else {}
      } else {
        final dy = end.offset.dy - start.offset.dy;
        _path.relativeArcToPoint(
          Offset(-radius, radius),
          radius: Radius.circular(radius),
          clockwise: false,
        );
        if (dy > 2 * radius) {
          _path.relativeLineTo(0, dy - 2 * radius);
          _path.relativeArcToPoint(
            Offset(radius, radius),
            radius: Radius.circular(radius),
            clockwise: false,
          );
        } else {}
      }
    }
  }

  void _lu() {}

  void _lr() {}

  void _ld() {}

  void _la() {}

  void _ul() {}

  void _uu() {}

  void _ur() {}

  void _ud() {}

  void _ua() {}

  void _rl() {}

  void _ru() {}

  void _rr() {}

  void _rd() {}

  void _ra() {}

  void _dl() {}

  void _du() {}

  void _dr() {}

  void _dd() {}

  void _da() {}

  void _al() {}

  void _au() {}

  void _ar() {}

  void _ad() {}

  void _aa() {}

  void _lur(double dx) {}
  void _ldr(double dx) {}

  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_path, style.back);
    canvas.drawPath(_path, style.stroke);
  }
}

class LineStyle {
  final Paint stroke;
  final Paint back;

  LineStyle({
    required Color color,
    required Color backgroundColor,
    double strokeWidth = 1.0,
    double sigma = 8,
  }) : stroke = Paint()
         ..style = PaintingStyle.stroke
         ..color = color
         ..strokeWidth = strokeWidth,
       back = Paint()
         ..style = PaintingStyle.stroke
         ..color = backgroundColor
         ..strokeWidth = 2 * sigma
         ..imageFilter = ImageFilter.blur(sigmaX: sigma, sigmaY: sigma);
}
