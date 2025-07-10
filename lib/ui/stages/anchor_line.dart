import 'dart:ui';

import 'package:studio/ui/figures/figure.dart';
import 'package:studio/ui/stages/line.dart';
import 'package:studio/ui/stages/lines/any_any.dart';
import 'package:studio/ui/stages/lines/any_down.dart';
import 'package:studio/ui/stages/lines/any_left.dart';
import 'package:studio/ui/stages/lines/any_right.dart';
import 'package:studio/ui/stages/lines/any_up.dart';
import 'package:studio/ui/stages/lines/down_any.dart';
import 'package:studio/ui/stages/lines/down_down.dart';
import 'package:studio/ui/stages/lines/down_left.dart';
import 'package:studio/ui/stages/lines/down_right.dart';
import 'package:studio/ui/stages/lines/down_up.dart';
import 'package:studio/ui/stages/lines/left_any.dart';
import 'package:studio/ui/stages/lines/left_down.dart';
import 'package:studio/ui/stages/lines/left_left.dart';
import 'package:studio/ui/stages/lines/left_right.dart';
import 'package:studio/ui/stages/lines/left_up.dart';
import 'package:studio/ui/stages/lines/right_any.dart';
import 'package:studio/ui/stages/lines/right_down.dart';
import 'package:studio/ui/stages/lines/right_left.dart';
import 'package:studio/ui/stages/lines/right_right.dart';
import 'package:studio/ui/stages/lines/right_up.dart';
import 'package:studio/ui/stages/lines/up_any.dart';
import 'package:studio/ui/stages/lines/up_down.dart';
import 'package:studio/ui/stages/lines/up_left.dart';
import 'package:studio/ui/stages/lines/up_right.dart';
import 'package:studio/ui/stages/lines/up_up.dart';

enum Direction { left, up, right, down, any }

typedef Anchor = ({Direction direction, Offset offset});

class AnchorLine implements Paintable {
  final LineStyle style;
  late final Line _line;

  AnchorLine({
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
    }(start: start.offset, end: end.offset, radius: radius, style: style);
  }

  @override
  void paint(Canvas canvas) {
    _line.paint(canvas);
  }
}
