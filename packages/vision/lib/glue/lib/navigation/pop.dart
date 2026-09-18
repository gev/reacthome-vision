import 'package:flutter/widgets.dart';
import 'package:glue/context.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue_flutter/glue_flutter.dart';
import 'package:vision/glue/lib/navigation/find_navigator.dart';

Ir pop(bool rootNavigator) => IrNativeFunc((Ir ir) {
  return getRuntime().bind((runtime) {
    final context = getFromContext<BuildContext>(runtime.context);
    if (context != null) {
      final targetNavigator = switch (ir) {
        IrObject(:final properties) => extractFromGlobalKey(
          properties['target'],
        ),
        _ => null,
      };
      final navigator = findNavigator(context, rootNavigator, targetNavigator);
      if (navigator.canPop()) {
        navigator.pop();
      }
    }
    return Eval.pure(IrVoid());
  });
});
