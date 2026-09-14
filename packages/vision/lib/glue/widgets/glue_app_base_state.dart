import 'package:flutter/material.dart';
import 'package:glue/context.dart';
import 'package:glue/either.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/app.dart';
import 'package:vision/glue/extract.dart';
import 'package:vision/scope.dart';

abstract class GlueAppBaseState<T extends StatefulWidget> extends State<T> {
  App cachedApp = defaultApp;
  Ir? lastEvaluatedExpression;
  late final Scope scope;
  bool initialized = false;

  Ir get widgetApp;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!initialized) {
      initialized = true;
      scope = Scope.of(context);
      scope.reactiveRuntime.addListener(run);
    }
    run();
  }

  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);
    runGuarded();
  }

  void runGuarded() {
    if (lastEvaluatedExpression == widgetApp) {
      return;
    }
    run();
  }

  void run() {
    lastEvaluatedExpression = widgetApp;

    final evaluation = eval(widgetApp);
    final result = runEval(
      evaluation,
      scope.reactiveRuntime.runtime.copyWith(
        context: putToContext<BuildContext>(
          scope.reactiveRuntime.runtime.context,
          context,
        ),
      ),
    );

    result.match((err) => scope.log.error(err), (res) {
      if (mounted) {
        final (val, _) = res;
        final newApp = extractLast<App>(val);
        if (newApp == null) {
          scope.log.error('$widgetApp \n App required');
        } else {
          setState(() {
            cachedApp = newApp;
          });
        }
      }
    });
  }

  Route<dynamic>? generateRoute(RouteSettings settings) {
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

  @override
  void dispose() {
    scope.reactiveRuntime.removeListener(run);
    super.dispose();
  }
}
