import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:glue/context.dart';
import 'package:glue/either.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/app.dart';
import 'package:vision/glue/extract.dart';
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

class _GlueAppState extends State<GlueApp> with WidgetsBindingObserver {
  App _cachedApp = defaultApp;
  Locale _currentLocale = WidgetsBinding.instance.platformDispatcher.locale;

  // Caches to prevent duplicate evaluation cycles
  Ir? _lastEvaluatedexpression;

  late final Scope _scope;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

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

  @override
  void didChangeLocales(List<Locale>? locales) {
    super.didChangeLocales(locales);
    final newLocale = WidgetsBinding.instance.platformDispatcher.locale;
    setState(() {
      _currentLocale = newLocale;
    });
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
          final newApp = extractLast<App>(val);
          if (newApp == null) {
            _scope.log.error('${widget.app} \n App required');
          } else {
            _updateApp(newApp);
          }
        }
      },
    );
  }

  void _updateApp(App newApp) {
    setState(() {
      _cachedApp = newApp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.title,
      key: ValueKey((_currentLocale, _cachedApp)),
      themeMode: ThemeMode.system,
      theme: makeTheme(_cachedApp, Brightness.light),
      darkTheme: makeTheme(_cachedApp, Brightness.dark),
      locale: _currentLocale,
      supportedLocales: WidgetsBinding.instance.platformDispatcher.locales,
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: widget.splash,
      onGenerateRoute: (RouteSettings settings) {
        final routeBuilder = _cachedApp.routes[settings.name];

        if (routeBuilder == null) {
          _scope.log.error('Route `${settings.name}` not found');
          return null;
        }

        final evaluation = eval(
          IrList([routeBuilder, toIr(settings.arguments)]),
        );
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
            final route = to<Route<Ir>>(value.$1);
            if (route == null) {
              _scope.log.error('Route `${settings.name}` not found');
              return null;
            }
            return route;
        }
      },
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scope.reactiveRuntime.removeListener(_run);
    super.dispose();
  }
}
