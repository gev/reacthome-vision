import 'package:flutter/material.dart';
import 'package:glue/env.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/route.dart';
import 'package:vision/glue/widgets/glue_widget.dart';

final Ir route = IrSpecial(routeImpl);

Eval<Ir> routeImpl(List<Ir> ir) {
  switch (ir) {
    case [IrObject(:final properties)]:
      final screen = properties['screen'];
      if (screen == null) {
        return throwError(
          wrongArgumentType(['`screen` lambda  propery required']),
        );
      }
      return getEnv().bind((env) {
        return Eval.pure(
          IrNativeValue(Value(makeRouteBuilder(screen: screen, env: env))),
        );
      });
    default:
      return throwError(wrongArgumentType(['Route `Object` required']));
  }
}

RouteBuilder makeRouteBuilder({required Ir screen, required Env env}) =>
    (RouteSettings settings) => MaterialPageRoute(
      builder: (_) {
        return GlueWidget(
          expression: IrList([screen, toIr(settings.arguments)]),
          env: env,
        );
      },
    );
