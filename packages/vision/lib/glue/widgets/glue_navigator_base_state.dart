import 'package:flutter/material.dart';
import 'package:glue/context.dart';
import 'package:glue/either.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/app.dart';
import 'package:vision/scope.dart';

abstract class GlueNavigatorBaseState<T extends StatefulWidget>
    extends State<T> {
  late final Scope scope;
  bool _initialized = false;

  Routes get routes;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      scope = Scope.of(context);
    }
  }

  Route<dynamic>? generateRoute(RouteSettings settings) {
    final routeBuilder = routes[settings.name];
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
}
