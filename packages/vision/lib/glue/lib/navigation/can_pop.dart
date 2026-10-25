import 'package:flutter/widgets.dart';
import 'package:glue/context.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue_flutter/glue_flutter.dart';
import 'package:vision/glue/lib/navigation/find_navigator.dart';

/// Checks if the navigation stack can pop, supporting optional :target and root checks
Ir canPop(bool rootNavigator) => IrNativeFunc((Ir ir) {
  return getRuntime().bind((runtime) {
    final context = getFromContext<BuildContext>(runtime.context);
    final targetNavigator = switch (ir) {
      IrObject(:final properties) => extractFromGlobalKey(properties['target']),
      _ => null,
    };
    final navigator = findNavigator(context, rootNavigator, targetNavigator);
    final canPop = navigator != null ? navigator.canPop() : false;
    return Eval.pure(IrBool(canPop));
  });
});
