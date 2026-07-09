import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:glue/context.dart';
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

  // Tracks execution sequence to prevent async race conditions
  int _currentExecutionId = 0;

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

  final _key = GlobalKey();

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
        final RouteBuilder? routeBuilder = _cachedProps.routes[settings.name];

        if (routeBuilder == null) {
          return MaterialPageRoute(
            builder: (_) =>
                const Scaffold(body: Center(child: Text('Route not found'))),
          );
        }

        if (settings.name == 'light-dimmer') {
          final widgetBuilder = routeBuilder(settings);
          final screen = widgetBuilder(context);
          return PageRouteBuilder(
            settings: settings,
            opaque: false,
            pageBuilder: (context, animation, secondaryAnimation) {
              var isClosing = false;
              final navigator = Navigator.of(context);
              final theme = Theme.of(context);
              final background = theme.colorScheme.surface;
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  isClosing = true;
                  navigator.pop();
                },
                onVerticalDragUpdate: (details) {
                  if (!isClosing && details.delta.dy.abs() > 10) {
                    isClosing = true;
                    navigator.pop();
                  }
                },
                child: Hero(
                  tag: settings.arguments!,
                  flightShuttleBuilder:
                      (
                        flightContext,
                        animation,
                        direction,
                        fromContext,
                        toContext,
                      ) {
                        final isPush = direction == HeroFlightDirection.push;

                        final fadeOutWidget = isPush
                            ? fromContext.widget
                            : toContext.widget;

                        final fadeInWidget = isPush
                            ? toContext.widget
                            : fromContext.widget;

                        return Stack(
                          children: [
                            Positioned.fill(
                              child: FadeTransition(
                                opacity: animation.drive(
                                  Tween(begin: 1.0, end: 0.0),
                                ),
                                child: fadeOutWidget,
                              ),
                            ),
                            Positioned.fill(
                              child: FadeTransition(
                                opacity: animation,
                                child: fadeInWidget,
                              ),
                            ),
                          ],
                        );
                      },
                  child: AnimatedBuilder(
                    key: _key,
                    animation: animation,
                    builder: (context, _) {
                      final blur = 50 * animation.value;
                      final radius = 12 * (1 - animation.value);
                      return ClipRRect(
                        borderRadius: BorderRadiusGeometry.all(
                          Radius.circular(radius),
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                          child: Material(
                            type: MaterialType.transparency,
                            child: Container(
                              padding: EdgeInsets.all(16),
                              color: background.withValues(alpha: 0.75),
                              child: Center(
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: screen,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
            transitionDuration: Duration(milliseconds: 500),
            reverseTransitionDuration: Duration(milliseconds: 500),
          );
        }

        return MaterialPageRoute(builder: routeBuilder(settings));
      },
    );
  }

  @override
  void dispose() {
    _scope.reactiveRuntime.removeListener(_run);
    super.dispose();
  }
}
