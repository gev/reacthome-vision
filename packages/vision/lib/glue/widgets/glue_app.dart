import 'package:flutter/material.dart';
import 'package:glue/context.dart';
import 'package:glue/either.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/extract.dart';
import 'package:vision/glue/route.dart';
import 'package:vision/scope.dart';
import 'package:vision/widgets/theme.dart';

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
  Props _cachedProps = (routes: {});

  // Caches to prevent duplicate evaluation cycles
  Ir? _lastEvaluatedexpression;

  late final Scope _scope;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      _scope = Scope.of(context);
      _scope.reactiveRuntime.addListener(_run);
    }
    _run();
  }

  @override
  void didUpdateWidget(GlueApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runGuarded();
  }

  void _runGuarded() {
    // Guard against duplicate executions
    if (_lastEvaluatedexpression == widget.app) {
      return;
    }
    _run();
  }

  void _run() {
    _lastEvaluatedexpression = widget.app;

    final evaluation = eval(widget.app);
    final result = runEval(
      evaluation,
      _scope.reactiveRuntime.runtime.copyWith(
        context: putToContext<BuildContext>(
          _scope.reactiveRuntime.runtime.context,
          context,
        ),
      ),
    );

    result.match(
      (err) {
        _scope.log.error(err);
      },
      (res) {
        if (mounted) {
          final (val, _) = res;
          final newProps = extractLast<Props>(val);
          if (newProps == null) {
            _scope.log.error('${widget.app} \n Routes required');
          } else {
            _updateRoutes(newProps);
          }
        }
      },
    );
  }

  void _updateRoutes(Props newProps) {
    setState(() {
      _cachedProps = newProps;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.title,
      key: ValueKey(_cachedProps),
      themeMode: ThemeMode.system,
      theme: makeTheme(
        Color.from(alpha: 1, red: 1, green: 0.5, blue: 0.5),
        Brightness.light,
      ),
      darkTheme: makeTheme(
        Color.from(alpha: 1, red: 1, green: 0.5, blue: 0.5),
        Brightness.dark,
      ),
      home: widget.splash,
      onGenerateRoute: (RouteSettings settings) {
        final IrClosure? routeBuilder = _cachedProps.routes[settings.name];

        if (routeBuilder == null) {
          _scope.log.error('Route `${settings.name}` not found');
          return null;
        }

        final evaluation = apply(routeBuilder, [toIr(settings.arguments)]);
        final result = runEval(
          evaluation,
          _scope.reactiveRuntime.runtime.copyWith(
            context: putToContext<BuildContext>(
              _scope.reactiveRuntime.runtime.context,
              context,
            ),
          ),
        );

        switch (result) {
          case Left(value: final err):
            _scope.log.error('Route `${settings.name}` internal error $err');
            return null;
          case Right(:final value):
            final routeBuilder = to<RouteBuilder>(value.$1);
            if (routeBuilder == null) {
              _scope.log.error('Route `${settings.name}` not found');
              return null;
            }
            return routeBuilder(settings);
        }
      },
    );
  }

  @override
  void dispose() {
    _scope.reactiveRuntime.removeListener(_run);
    super.dispose();
  }
}
