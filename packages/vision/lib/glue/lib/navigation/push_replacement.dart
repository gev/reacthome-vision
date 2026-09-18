import 'package:flutter/widgets.dart';
import 'package:glue/context.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/app.dart';
import 'package:vision/glue/lib/navigation/find_navigator.dart';

/// Replaces the current route with a new Route
Ir pushReplacement(bool rootNavigator) => IrNativeFunc((Ir ir) {
  return getRuntime().bind((runtime) {
    final context = getFromContext<BuildContext>(runtime.context);
    if (context != null) {
      return evalRoute(ir).bind((entry) {
        final navigator = findNavigator(context, rootNavigator, entry.target);
        return routeResult(
          navigator.pushReplacementNamed(entry.route, arguments: entry.args),
        );
      });
    }
    return Eval.pure(IrVoid());
  });
});
