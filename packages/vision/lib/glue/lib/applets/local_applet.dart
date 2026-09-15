import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/scope_factory.dart';

Ir localApplet = IrNativeFunc(
  (Ir props) => switch (props) {
    IrObject(:final properties) => _createLocalApplet(properties.unlock),
    _ => throwError(wrongArgumentType(['Properties `Object` required'])),
  },
);

Eval<Ir> _createLocalApplet(Map<String, Ir> props) {
  final id = toString(props['id']);
  if (id == null) {
    return throwError(wrongArgumentType(['Applet `id` required']));
  }
  final widget = ScopeFactory.makeLocalApplet(
    id: id,
    title: toString(props['title']) ?? '',
    codePath: toString(props['code-path']) ?? '.',
  );
  return Eval.pure(IrNativeValue(Value(widget)));
}
