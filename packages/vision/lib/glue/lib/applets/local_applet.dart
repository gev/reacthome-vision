import 'dart:io';

import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/mode/local/local_scope.dart';
import 'package:vision/widgets/vision_applet.dart';

Ir localApplet(Directory path) => IrNativeFunc(
  (Ir props) => switch (props) {
    IrObject(:final properties) => _createLocalApplet(path, properties.unlock),
    _ => throwError(wrongArgumentType(['Properties `Object` required'])),
  },
);

Eval<Ir> _createLocalApplet(Directory path, Map<String, Ir> props) {
  final codePath = to<String>(props['code-path']) ?? '.';
  final title = to<String>(props['title']) ?? '';
  final widget = makeLocalScope(
    path: path,
    codePath: codePath,
    child: VisionApplet(title: title),
  );
  return Eval.pure(IrNativeValue(Value(widget)));
}
