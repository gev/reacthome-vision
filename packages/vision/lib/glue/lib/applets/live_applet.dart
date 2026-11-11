import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue_flutter/glue_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:vision/glue/discovery_store.dart';
import 'package:vision/glue/runtime/live/hybrid/hybrid_live_applet.dart';

Ir liveApplet(DiscoveryStore store) => IrNativeFunc(
  (Ir props) => _createLiveApplet(store, props, WidgetProperties(props)),
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
  try {
    final peer = Uuid.parseAsByteList(id);
    print(id);
    print(peer);
    print(Uuid.unparse(peer));
    final title = props.getString('title') ?? '';
    final widget = makeHybridLiveApplet(
      id: id,
      title: title,
      peer: peer,
      discoveryStore: store,
      args: args,
      key: props.key,
    );
    return Eval.pure(IrNativeValue(Value(widget)));
  } catch (e) {
    return throwError(wrongArgumentType(['Applet `id` must be a valid UUID']));
  }
}
