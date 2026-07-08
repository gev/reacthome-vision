import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:glue/context.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/extract.dart';
import 'package:vision/scope.dart';
import 'package:vision/widgets/theme.dart';

typedef Props = ({Routes routes});
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
        final WidgetBuilder? builder = _cachedProps.routes[settings.name];

        if (builder == null) {
          return MaterialPageRoute(
            builder: (_) =>
                const Scaffold(body: Center(child: Text('Route not found'))),
          );
        }
        if (settings.name == 'light-dimmer') {
          return PageRouteBuilder(
            settings: settings,
            opaque: false,
            pageBuilder: (context, animation, secondaryAnimation) {
              final navigator = Navigator.of(context);
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => navigator.pop(),
                onVerticalDragUpdate: (details) {
                  if (details.delta.dy.abs() > 10) {
                    navigator.pop();
                  }
                },
                child: Hero(
                  tag: "123",
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
                    animation: animation,
                    builder: (context, _) {
                      final blur = 50 * animation.value;
                      final background = Theme.of(context).colorScheme.surface;
                      return BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                        child: Material(
                          type: MaterialType.transparency,
                          child: Container(
                            color: background.withValues(alpha: 0.7),
                            child: Center(child: builder(context)),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
            // transitionDuration: Duration(milliseconds: 1000),
            // reverseTransitionDuration: Duration(milliseconds: 1000),
          );
        }

        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }

  @override
  void dispose() {
    _scope.reactiveRuntime.removeListener(_run);
    super.dispose();
  }
}
