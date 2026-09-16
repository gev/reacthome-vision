import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue_flutter/glue_flutter.dart';
import 'package:vision/glue/widgets/glue_navigator.dart';

/// Creates a GlueNavigator from an IrObject
final Ir navigator = IrNativeFunc(navigatorImpl);

Eval<Ir> navigatorImpl(Ir ir) {
  switch (ir) {
    case IrObject app:
      final props = WidgetProperties(app.properties.unlock);
      return Eval.pure(
        IrNativeValue(Value(GlueNavigator(key: props.key, app: app))),
      );
    default:
      return throwError(
        wrongArgumentType(['Properties `Object` required for navigator']),
      );
  }
}
