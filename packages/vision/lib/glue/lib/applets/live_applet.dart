import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue_flutter/glue_flutter.dart';
import 'package:vision/scope_factory.dart';

Ir liveApplet = IrNativeFunc(
  (Ir props) => switch (props) {
    IrObject(:final properties) => _createLiveApplet(
      WidgetProperties(properties.unlock),
    ),
    _ => throwError(wrongArgumentType(['Properties `Object` required'])),
  },
);

Eval<Ir> _createLiveApplet(WidgetProperties props) {
  final id = props.getString('id');
  if (id == null) {
    return throwError(wrongArgumentType(['Applet `id` required']));
  }
  final widget = ScopeFactory.makeLiveApplet(
    id: id,
    key: props.key,
    title: props.getString('title') ?? '',
    host: props.getString('host') ?? '127.0.0.1',
    port: props.getInt('port') ?? 3005,
  );
  return Eval.pure(IrNativeValue(Value(widget)));
}
