import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/scope_factory.dart';

Ir liveApplet = IrNativeFunc(
  (Ir props) => switch (props) {
    IrObject(:final properties) => _createLiveApplet(properties.unlock),
    _ => throwError(wrongArgumentType(['Properties `Object` required'])),
  },
);

Eval<Ir> _createLiveApplet(Map<String, Ir> props) {
  final id = to<String>(props['id']);
  if (id == null) {
    return throwError(wrongArgumentType(['Applet `id` required']));
  }
  final widget = ScopeFactory.makeLiveApplet(
    id: id,
    title: to<String>(props['title']) ?? '',
    host: to<String>(props['host']) ?? '127.0.0.1',
    port: to<int>(props['port']) ?? 3005,
  );
  return Eval.pure(IrNativeValue(Value(widget)));
}
