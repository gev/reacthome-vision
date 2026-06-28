import 'package:flutter/widgets.dart';
import 'package:glue/context.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/lib/navigation/route.dart';

/// Replaces the current route with a new Route
final Ir pushReplacement = IrNativeFunc((Ir ir) {
  return getRuntime().bind((runtime) {
    final context = getFromContext<BuildContext>(runtime.context);
    if (context != null) {
      return evalRoute(ir).bind((entry) {
        final navigator = Navigator.of(context);
        return routeResult(
          navigator.pushReplacementNamed(entry.route, arguments: entry.args),
        );
      });
    }
    return Eval.pure(IrVoid());
  });
});
