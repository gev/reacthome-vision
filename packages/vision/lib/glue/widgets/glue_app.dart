import 'package:flutter/material.dart';
import 'package:glue/context.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/extract.dart';
import 'package:vision/navigation/app_navigator.dart';
import 'package:vision/scope.dart';
import 'package:vision/widgets/theme.dart';

typedef Routes = Map<String, WidgetBuilder>;

class GlueApp extends StatefulWidget {
  final String title;
  final Ir app;
  final Widget splash;

  const GlueApp({
    required this.title,
    required this.app,
    required this.splash,
    super.key,
  });

  @override
  State<GlueApp> createState() => _GlueAppState();
}

class _GlueAppState extends State<GlueApp> {
  Routes _cachedRoutes = {};

  // Tracks execution sequence to prevent async race conditions
  int _currentExecutionId = 0;

  // Caches to prevent duplicate evaluation cycles
  Ir? _lastEvaluatedexpression;

  late final Scope _scope;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scope = Scope.of(context);
    _scope.reactiveRuntime.addListener(_run);
    _run();
  }

  @override
  void didUpdateWidget(GlueApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runGuarded();
  }

  void _runGuarded() async {
    // Guard against duplicate executions
    if (_lastEvaluatedexpression == widget.app) {
      return;
    }
    _run();
  }

  void _run() async {
    _lastEvaluatedexpression = widget.app;

    // Increment ID to mark this specific async request batch
    final executionId = ++_currentExecutionId;

    final evaluation = eval(widget.app);
    final result = await runEval(
      evaluation,
      _scope.reactiveRuntime.runtime.copyWith(
        context: putToContext<BuildContext>(
          _scope.reactiveRuntime.runtime.context,
          context,
        ),
      ),
    );

    if (executionId != _currentExecutionId) return;

    result.match(
      (err) {
        _scope.log.error(err);
      },
      (res) {
        if (mounted) {
          final (val, _) = res;
          final newRoutes = extractLast<Routes>(val);
          if (newRoutes == null) {
            _scope.log.error('${widget.app} \n Routes required');
          } else {
            _updateRoutes(newRoutes);
          }
        }
      },
    );
  }

  void _updateRoutes(Routes newRoutes) {
    setState(() {
      _cachedRoutes = newRoutes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.title,
      navigatorKey: AppNavigator.navigatorKey,
      themeMode: ThemeMode.system,
      theme: makeTheme(Colors.blue, Brightness.light),
      darkTheme: makeTheme(Colors.blue, Brightness.dark),
      home: widget.splash,
      routes: _cachedRoutes,
    );
  }

  @override
  void dispose() {
    _scope.reactiveRuntime.removeListener(_run);
    super.dispose();
  }
}
