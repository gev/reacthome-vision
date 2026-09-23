import 'package:flutter/material.dart';
import 'package:glue/context.dart';
import 'package:glue/either.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/app.dart';
import 'package:vision/glue/runtime/scope.dart';

Route<dynamic>? generateGlueRoute(
  RouteSettings settings, {
  required App cachedApp,
  required Scope scope,
  required BuildContext context,
  Widget? splashWidget,
}) {
  if (settings.name == 'splash' && splashWidget != null) {
    return MaterialPageRoute(settings: settings, builder: (_) => splashWidget);
  }

  final routeBuilder = cachedApp.routes[settings.name];
  if (routeBuilder == null) {
    scope.log.error('Route `${settings.name}` not found');
    return null;
  }

  final evaluation = apply(routeBuilder, [toIr(settings.arguments)]);
  final result = runEval(
    evaluation,
    scope.reactiveRuntime.runtime.copyWith(
      context: putToContext<BuildContext>(
        scope.reactiveRuntime.runtime.context,
        context,
      ),
    ),
  );

  switch (result) {
    case Left(value: final err):
      scope.log.error('Route `${settings.name}` internal error $err');
      return null;
    case Right(:final value):
      final route = to<Route<Ir>>(value.$1);
      if (route == null) {
        scope.log.error('Route `${settings.name}` not found');
        return null;
      }
      return route;
  }
}
