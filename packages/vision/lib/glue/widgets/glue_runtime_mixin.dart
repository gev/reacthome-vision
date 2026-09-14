import 'package:flutter/widgets.dart';
import 'package:glue/context.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/app.dart';
import 'package:vision/glue/extract.dart';
import 'package:vision/scope.dart';

mixin GlueRuntimeMixin<T extends StatefulWidget> on State<T> {
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

  void didUpdateWidgetRuntime() {
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
          updateApp(newApp);
        }
      }
    });
  }

  void updateApp(App newApp);

  void disposeRuntime() {
    scope.reactiveRuntime.removeListener(run);
  }
}
