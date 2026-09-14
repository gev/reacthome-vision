import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/mode/local/local_scope.dart';
import 'package:vision/widgets/vision_app.dart';

final Ir localApplet = IrNativeFunc(_localAppletImpl);

Eval<Ir> _localAppletImpl(Ir props) => switch (props) {
  IrObject(:final properties) => _createLocalApplet(properties.unlock),
  _ => throwError(wrongArgumentType(['Properties `Object` required'])),
};

Eval<Ir> _createLocalApplet(Map<String, Ir> props) {
  final codePath = to<String>(props['code-path']) ?? '.';
  final title = to<String>(props['title']) ?? '';
  final widget = makeLocalScope(
    codePath: codePath,
    child: VisionApp(title: title),
  );
  return Eval.pure(IrNativeValue(Value(widget)));
}
