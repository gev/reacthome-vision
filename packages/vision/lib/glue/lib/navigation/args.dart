import 'package:flutter/widgets.dart';
import 'package:glue/context.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';

final Ir args = IrEvaluable(() {
  return getRuntime().bind((runtime) {
    final context = getFromContext<BuildContext>(runtime.context);
    return Eval.pure(
      context != null
          ? switch (ModalRoute.of(context)?.settings.arguments) {
              IrObject args => args,
              _ => IrObject({}),
            }
          : IrObject({}),
    );
  });
});
