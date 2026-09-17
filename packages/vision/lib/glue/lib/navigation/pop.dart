import 'package:flutter/widgets.dart';
import 'package:glue/context.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/widgets/glue_navigator_finder.dart';

/// Pops the current route, optionally passing a result
final Ir pop = IrNativeFunc(
  (Ir resultIr) => getRuntime().bind((runtime) {
    final context = getFromContext<BuildContext>(runtime.context);
    if (context != null) {
      findNavigatorToPop(context)?.pop(resultIr);
    }
    return Eval.pure(IrVoid());
  }),
);
