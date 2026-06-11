import 'package:flutter/material.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/widgets/glue_widget.dart';

/// Creates a Routes from an IrObject
final Ir routes = IrSpecial(
  (List<Ir> routesIr) => getEnv().bind((env) {
    switch (routesIr) {
      case [IrObject(properties: final routes)]:
        final res = <String, WidgetBuilder>{};
        for (final route in routes.entries) {
          res[route.key] = (_) {
            return GlueWidget(expression: route.value, env: env);
          };
        }
        return Eval.pure(IrNativeValue(Value(res)));
      default:
        return throwError(wrongArgumentType(['required routers map']));
    }
  }),
);
