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
          switch (route.value) {
            case (IrSymbol builder):
              res[route.key] = (_) {
                return GlueWidget(
                  expression: IrList([builder, IrList([])]),
                  env: env,
                );
              };
            default:
              return throwError(
                RuntimeException('Builder should be a symbol', route.value),
              );
          }
        }
        return Eval.pure(IrNativeValue(Value(res)));
      default:
        return throwError(wrongArgumentType(['required routers map']));
    }
  }),
);
