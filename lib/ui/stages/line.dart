import 'dart:ui';

import 'package:studio/ui/figures/figure.dart';
import 'package:studio/ui/stages/line_path.dart';
import 'package:studio/ui/stages/line_paths/any_any.dart';
import 'package:studio/ui/stages/line_paths/any_down.dart';
import 'package:studio/ui/stages/line_paths/any_left.dart';
import 'package:studio/ui/stages/line_paths/any_right.dart';
import 'package:studio/ui/stages/line_paths/any_up.dart';
import 'package:studio/ui/stages/line_paths/down_any.dart';
import 'package:studio/ui/stages/line_paths/down_down.dart';
import 'package:studio/ui/stages/line_paths/down_left.dart';
import 'package:studio/ui/stages/line_paths/down_right.dart';
import 'package:studio/ui/stages/line_paths/down_up.dart';
import 'package:studio/ui/stages/line_paths/left_any.dart';
import 'package:studio/ui/stages/line_paths/left_down.dart';
import 'package:studio/ui/stages/line_paths/left_left.dart';
import 'package:studio/ui/stages/line_paths/left_right.dart';
import 'package:studio/ui/stages/line_paths/left_up.dart';
import 'package:studio/ui/stages/line_paths/right_any.dart';
import 'package:studio/ui/stages/line_paths/right_down.dart';
import 'package:studio/ui/stages/line_paths/right_left.dart';
import 'package:studio/ui/stages/line_paths/right_right.dart';
import 'package:studio/ui/stages/line_paths/right_up.dart';
import 'package:studio/ui/stages/line_paths/up_any.dart';
import 'package:studio/ui/stages/line_paths/up_down.dart';
import 'package:studio/ui/stages/line_paths/up_left.dart';
import 'package:studio/ui/stages/line_paths/up_right.dart';
import 'package:studio/ui/stages/line_paths/up_up.dart';

enum Direction { left, up, right, down, any }

typedef Anchor = ({Direction direction, Offset offset});

class Line implements Paintable {
  final LineStyle style;
  late final LinePath _line;

  Line({
    required Anchor start,
    required Anchor end,
    double radius = 24,
    required this.style,
  }) {
    _line = switch (start.direction) {
      Direction.left => switch (end.direction) {
        Direction.left => LeftLeft.new,
        Direction.up => LeftUp.new,
        Direction.right => LeftRight.new,
        Direction.down => LeftDown.new,
        Direction.any => LeftAny.new,
      },
      Direction.up => switch (end.direction) {
        Direction.left => UpLeft.new,
        Direction.up => UpUp.new,
        Direction.right => UpRight.new,
        Direction.down => UpDown.new,
        Direction.any => UpAny.new,
      },
      Direction.right => switch (end.direction) {
        Direction.left => RightLeft.new,
        Direction.up => RightUp.new,
        Direction.right => RightRight.new,
        Direction.down => RightDown.new,
        Direction.any => RightAny.new,
      },
      Direction.down => switch (end.direction) {
        Direction.left => DownLeft.new,
        Direction.up => DownUp.new,
        Direction.right => DownRight.new,
        Direction.down => DownDown.new,
        Direction.any => DownAny.new,
      },
      Direction.any => switch (end.direction) {
        Direction.left => AnyLeft.new,
        Direction.up => AnyUp.new,
        Direction.right => AnyRight.new,
        Direction.down => AnyDown.new,
        Direction.any => AnyAny.new,
      },
    }(start: start.offset, end: end.offset, radius: radius);
  }

  @override
  void paint(Canvas canvas) {
    canvas.drawPath(_line.path, style.back);
    canvas.drawPath(_line.path, style.stroke);
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
