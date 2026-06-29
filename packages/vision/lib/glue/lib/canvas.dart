import 'package:glue/module.dart';
import 'package:vision/glue/lib/canvas/line_to.dart';
import 'package:vision/glue/lib/canvas/move_to.dart';
import 'package:vision/glue/lib/canvas/paint.dart';
import 'package:vision/glue/lib/canvas/path.dart';

final ModuleInfo canvasModule = nativeModule('ffi.vision.canvas', [
  ('paint', paint),
  ('path', path),
  ('move-to', moveTo),
  ('line-to', lineTo),
]);
