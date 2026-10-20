import 'package:flutter/material.dart';
import 'package:glue/env.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/widgets/glue_widget.dart';

final Ir route = IrSpecial(routeImpl);

Eval<Ir> routeImpl(List<Ir> ir) {
  switch (ir) {
    case [IrObject(:final properties)]:
      final screen = properties['screen'];
      if (screen == null) {
        return throwError(wrongArgumentType(['`screen  property required']));
      }
      return getEnv().bind((env) {
        return Eval.pure(
          IrNativeValue(
            Value(
              (settings) => makeRouteBuilder(
                screen: screen,
                env: env,
                settings: settings,
              ),
            ),
          ),
        );
      });
    default:
      return throwError(wrongArgumentType(['Route `Object` required']));
  }
}

Route<Ir> makeRouteBuilder({
  required Ir screen,
  required Env env,
  required RouteSettings settings,
}) => MaterialPageRoute(
  settings: settings,
  builder: (_) {
    return GlueWidget(expression: screen, env: env);
  },
);
