import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue_flutter/glue_flutter.dart';
import 'package:vision/glue/widgets/glue_navigator.dart';

/// Creates a GlueNavigator from an IrObject
final Ir navigator = IrNativeFunc(navigatorImpl);

Eval<Ir> navigatorImpl(Ir ir) {
  switch (ir) {
    case IrObject(:final properties):
      final props = WidgetProperties(properties.unlock);
      switch (props.get('routes')) {
        case IrObject(properties: final routes):
          return Eval.pure(
            IrNativeValue(
              Value(GlueNavigator(key: props.key, routes: routes.unlock)),
            ),
          );
        default:
          return throwError(
            wrongArgumentType(['Object `routes` property required']),
          );
      }
    default:
      return throwError(
        wrongArgumentType(['Properties `Object` required for navigator']),
      );
  }
}
