import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/mode/live/live_scope.dart';
import 'package:vision/widgets/vision_app.dart';

final Ir liveApplet = IrNativeFunc(_liveAppletImpl);

Eval<Ir> _liveAppletImpl(Ir props) => switch (props) {
  IrObject(:final properties) => _createLiveApplet(properties.unlock),
  _ => throwError(wrongArgumentType(['Properties `Object` required'])),
};

Eval<Ir> _createLiveApplet(Map<String, Ir> props) {
  final host = to<String>(props['host']) ?? '127.0.0.1';
  final port = to<int>(props['port']) ?? 3005;
  final title = to<String>(props['title']) ?? '';
  final widget = makeLiveScope(
    host: host,
    port: port,
    child: VisionApp(title: title),
  );
  return Eval.pure(IrNativeValue(Value(widget)));
}
