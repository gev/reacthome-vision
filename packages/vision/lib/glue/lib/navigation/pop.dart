import 'package:flutter/widgets.dart';
import 'package:glue/context.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/navigation/app_navigator.dart';

/// Pops the current route, optionally passing a result
final Ir pop = IrNativeFunc(
  (Ir resultIr) => getRuntime().flatMap((runtime) {
    final context = getFromContext<BuildContext>(runtime.context);
    context != null
        ? Navigator.of(context).pop(resultIr)
        : AppNavigator.pop(resultIr);
    return Eval.pure(IrVoid());
  }),
);
