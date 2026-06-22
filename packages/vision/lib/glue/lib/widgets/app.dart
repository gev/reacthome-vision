import 'package:flutter/material.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/widgets/glue_widget.dart';

/// Creates a Routes from an IrObject
final Ir app = IrSpecial(
  (List<Ir> ir) => getEnv().bind((env) {
    switch (ir) {
      case [IrObject(:final properties)]:
        switch (properties['routes']) {
          case IrObject(properties: final routes):
            final builders = <String, WidgetBuilder>{};
            for (final route in routes.entries) {
              builders[route.key] = (_) {
                return GlueWidget(expression: route.value, env: env);
              };
            }
            return Eval.pure(IrNativeValue(Value((routes: builders))));
          default:
            return throwError(wrongArgumentType(['required routers map']));
        }
      default:
        return throwError(
          wrongArgumentType(['required application propertis']),
        );
    }
  }),
);
