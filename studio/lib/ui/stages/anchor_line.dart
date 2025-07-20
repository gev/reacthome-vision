import 'dart:ui';

import 'package:studio/ui/figures/figure.dart';
import 'package:studio/ui/stages/line.dart';
import 'package:studio/ui/stages/lines/auto_auto.dart';
import 'package:studio/ui/stages/lines/auto_down.dart';
import 'package:studio/ui/stages/lines/auto_left.dart';
import 'package:studio/ui/stages/lines/auto_right.dart';
import 'package:studio/ui/stages/lines/auto_up.dart';
import 'package:studio/ui/stages/lines/down_auto.dart';
import 'package:studio/ui/stages/lines/down_down.dart';
import 'package:studio/ui/stages/lines/down_left.dart';
import 'package:studio/ui/stages/lines/down_right.dart';
import 'package:studio/ui/stages/lines/down_up.dart';
import 'package:studio/ui/stages/lines/left_auto.dart';
import 'package:studio/ui/stages/lines/left_down.dart';
import 'package:studio/ui/stages/lines/left_left.dart';
import 'package:studio/ui/stages/lines/left_right.dart';
import 'package:studio/ui/stages/lines/left_up.dart';
import 'package:studio/ui/stages/lines/right_auto.dart';
import 'package:studio/ui/stages/lines/right_down.dart';
import 'package:studio/ui/stages/lines/right_left.dart';
import 'package:studio/ui/stages/lines/right_right.dart';
import 'package:studio/ui/stages/lines/right_up.dart';
import 'package:studio/ui/stages/lines/up_auto.dart';
import 'package:studio/ui/stages/lines/up_down.dart';
import 'package:studio/ui/stages/lines/up_left.dart';
import 'package:studio/ui/stages/lines/up_right.dart';
import 'package:studio/ui/stages/lines/up_up.dart';

enum Direction { left, up, right, down, auto }

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
        Direction.auto => LeftAuto.new,
      },
      Direction.up => switch (end.direction) {
        Direction.left => UpLeft.new,
        Direction.up => UpUp.new,
        Direction.right => UpRight.new,
        Direction.down => UpDown.new,
        Direction.auto => UpAuto.new,
      },
      Direction.right => switch (end.direction) {
        Direction.left => RightLeft.new,
        Direction.up => RightUp.new,
        Direction.right => RightRight.new,
        Direction.down => RightDown.new,
        Direction.auto => RightAuto.new,
      },
      Direction.down => switch (end.direction) {
        Direction.left => DownLeft.new,
        Direction.up => DownUp.new,
        Direction.right => DownRight.new,
        Direction.down => DownDown.new,
        Direction.auto => DownAuto.new,
      },
      Direction.auto => switch (end.direction) {
        Direction.left => AutoLeft.new,
        Direction.up => AutoUp.new,
        Direction.right => AutoRight.new,
        Direction.down => AutoDown.new,
        Direction.auto => AutoAuto.new,
      },
    }(start: start.offset, end: end.offset, radius: radius, style: style);
  }

  @override
  void paint(Canvas canvas) {
    _line.paint(canvas);
  }
}
