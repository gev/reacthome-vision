import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue_flutter/glue_flutter.dart';
import 'package:vision/scope_factory.dart';

Ir liveApplet = IrNativeFunc(
  (Ir props) => switch (props) {
    IrObject(:final properties) => _createLiveApplet(
      props,
      WidgetProperties(properties.unlock),
    ),
    _ => throwError(wrongArgumentType(['Properties `Object` required'])),
  },
);

Eval<Ir> _createLiveApplet(Ir args, WidgetProperties props) {
  final id = props.getString('id');
  if (id == null) {
    return throwError(wrongArgumentType(['Applet `id` required']));
  }
  final widget = ScopeFactory.makeLiveApplet(
    id: id,
    key: props.key,
    title: props.getString('title') ?? '',
    url: props.getString('url') ?? 'ws://localhost:3005/',
    args: args,
  );
  return Eval.pure(IrNativeValue(Value(widget)));
}
