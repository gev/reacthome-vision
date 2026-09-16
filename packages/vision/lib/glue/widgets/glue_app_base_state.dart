import 'package:flutter/material.dart';
import 'package:glue/context.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/app.dart';
import 'package:vision/glue/extract.dart';
import 'package:vision/glue/widgets/glue_navigator_base_state.dart';

abstract class GlueAppBaseState<T extends StatefulWidget>
    extends GlueNavigatorBaseState<T> {
  App cachedApp = defaultApp;
  Ir? _lastEvaluatedExpression;

  Ir get app;

  @override
  Routes get routes => cachedApp.routes;

  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      scope.reactiveRuntime.addListener(_run);
    }
    _run();
  }

  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runGuarded();
  }

  void _runGuarded() {
    if (_lastEvaluatedExpression == app) {
      return;
    }
    _run();
  }

  void _run() {
    _lastEvaluatedExpression = app;

    final evaluation = eval(app);
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
          scope.log.error('$app \n App required');
        } else {
          setState(() {
            cachedApp = newApp;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    scope.reactiveRuntime.removeListener(_run);
    super.dispose();
  }
}
