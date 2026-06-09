import 'package:flutter/widgets.dart';
import 'package:glue/context.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/navigation/app_navigator.dart';

/// Checks if the navigation stack can pop
final canPop = IrEvaluable(
  () => getRuntime().bind((runtime) {
    final context = getFromContext<BuildContext>(runtime.context);
    return Eval.pure(
      IrBool(
        context != null
            ? Navigator.of(context).canPop()
            : AppNavigator.canPop(),
      ),
    );
  }),
);
