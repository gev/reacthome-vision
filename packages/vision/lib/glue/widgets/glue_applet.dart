import 'package:flutter/material.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/widgets/glue_app_base_state.dart';
import 'package:vision/widgets/theme.dart';

class GlueApplet extends StatefulWidget {
  final Ir app;
  final Widget splash;

  const GlueApplet({required this.app, required this.splash, super.key});

  @override
  State<GlueApplet> createState() => _GlueAppletState();
}

class _GlueAppletState extends GlueAppBaseState<GlueApplet> {
  @override
  Ir get app => widget.app;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeData = makeTheme(cachedApp, theme.brightness);
    return PopScope(
      canPop: false,
      child: Theme(
        data: themeData ?? theme,
        child: Material(
          child: Navigator(
            observers: [HeroController()],
            onGenerateRoute: (settings) {
              if (settings.name == '/') {
                return MaterialPageRoute(
                  settings: settings,
                  builder: (_) => widget.splash,
                );
              }
              return generateRoute(settings);
            },
          ),
        ),
      ),
    );
  }
}
