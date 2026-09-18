import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue_flutter/glue_flutter.dart';
import 'package:vision/scope_factory.dart';

Ir localApplet = IrNativeFunc(
  (Ir props) => switch (props) {
    IrObject(:final properties) => _createLocalApplet(
      props,
      WidgetProperties(properties.unlock),
    ),
    _ => throwError(wrongArgumentType(['Properties `Object` required'])),
  },
);

Eval<Ir> _createLocalApplet(Ir args, WidgetProperties props) {
  final id = props.getString('id');
  if (id == null) {
    return throwError(wrongArgumentType(['Applet `id` required']));
  }
  final widget = ScopeFactory.makeLocalApplet(
    id: id,
    key: props.key,
    title: props.getString('title') ?? '',
    codePath: props.getString('code-path') ?? '.',
    args: args,
  );
  return Eval.pure(IrNativeValue(Value(widget)));
}
