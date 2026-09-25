import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue_flutter/glue_flutter.dart';
import 'package:vision/glue/discovery_store.dart';
import 'package:vision/glue/runtime/live/live_applet.dart';

Ir liveApplet(DiscoveryStore store) => IrNativeFunc(
  (Ir props) => switch (props) {
    IrObject(:final properties) => _createLiveApplet(
      store,
      props,
      WidgetProperties(properties.unlock),
    ),
    _ => throwError(wrongArgumentType(['Properties `Object` required'])),
  },
);

Eval<Ir> _createLiveApplet(
  DiscoveryStore store,
  Ir args,
  WidgetProperties props,
) {
  final id = props.getString('id');
  if (id == null) {
    return throwError(wrongArgumentType(['Applet `id` required']));
  }
  final widget = makeLiveApplet(
    id: id,
    key: props.key,
    title: props.getString('title') ?? '',
    discoveryStore: store,
    args: args,
  );
  return Eval.pure(IrNativeValue(Value(widget)));
}
