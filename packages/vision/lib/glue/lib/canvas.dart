import 'package:glue/module.dart';
import 'package:vision/glue/lib/canvas/enums.dart';
import 'package:vision/glue/lib/canvas/group.dart';
import 'package:vision/glue/lib/canvas/line_to.dart';
import 'package:vision/glue/lib/canvas/move_to.dart';
import 'package:vision/glue/lib/canvas/paint_style.dart';
import 'package:vision/glue/lib/canvas/path.dart';
import 'package:vision/glue/lib/canvas/relativeArcToPoint.dart';

final ModuleInfo canvasModule = nativeModule('ffi.vision.canvas', [
  ('group', group),
  ('paint-style', paintStyle),
  ('path', path),
  ('move-to', moveTo),
  ('line-to', lineTo),
  ('relative-arc-to-point', relativeArcToPoint),

  ('blend-mode', blendMode),
  ('stroke-cap', strokeCap),
  ('stroke-join', strokeJoin),
  ('painting-style', paintingStyle),
  ('filter-quality', filterQuality),
  ('path-fill-type', pathFillType),
  ('clip-op', clipOp),
  ('tile-mode', tileMode),
  ('point-mode', pointMode),
]);
