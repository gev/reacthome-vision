import 'package:glue/module.dart';
import 'package:vision/glue/lib/canvas/enums.dart';
import 'package:vision/glue/lib/canvas/line_to.dart';
import 'package:vision/glue/lib/canvas/move_to.dart';
import 'package:vision/glue/lib/canvas/paint.dart';
import 'package:vision/glue/lib/canvas/paint_style.dart';
import 'package:vision/glue/lib/canvas/path.dart';

final ModuleInfo canvasModule = nativeModule('ffi.vision.canvas', [
  ('paint', paint),
  ('paint-style', paintStyle),
  ('path', path),
  ('move-to', moveTo),
  ('line-to', lineTo),

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
