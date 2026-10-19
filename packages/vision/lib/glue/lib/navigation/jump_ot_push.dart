import 'package:flutter/widgets.dart';
import 'package:glue/context.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/app.dart';
import 'package:vision/glue/lib/navigation/find_navigator.dart';

Ir jumpOrPush(bool rootNavigator) => IrNativeFunc((Ir ir) {
  return getRuntime().bind((runtime) {
    final context = getFromContext<BuildContext>(runtime.context);
    if (context != null) {
      return evalRoute(ir).bind((entry) {
        final navigator = findNavigator(
          context,
          rootNavigator,
          entry.targetNavigator,
        );
        _jumpOrPushNamed(navigator, entry.route, arguments: entry.args);
        return Eval.pure(IrVoid());
      });
    }
    return Eval.pure(IrVoid());
  });
});

void _jumpOrPushNamed<T>(
  NavigatorState navigator,
  String route, {
  required IrObject arguments,
}) async {
  bool routeExists = false;
  navigator.popUntil((r) {
    if (r.settings.name == route) {
      routeExists = true;
    }
    return r.isFirst;
  });
  if (!routeExists) {
    navigator.pushNamed<T>(route, arguments: arguments);
  }
}
