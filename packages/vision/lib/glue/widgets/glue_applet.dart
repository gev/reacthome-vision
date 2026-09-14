import 'package:flutter/material.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/widgets/glue_app_base_state.dart';
import 'package:vision/widgets/theme.dart';

class GlueApplet extends StatefulWidget {
  final String title;
  final Ir app;
  final Widget splash;

  const GlueApplet({
    required this.title,
    required this.app,
    required this.splash,
    super.key,
  });

  @override
  State<GlueApplet> createState() => _GlueAppletState();
}

class _GlueAppletState extends GlueAppBaseState<GlueApplet> {
  @override
  Ir get widgetApp => widget.app;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeData = makeTheme(cachedApp, theme.brightness);
    return Theme(
      data: themeData ?? theme,
      child: Material(
        child: Navigator(
          initialRoute: 'splash',
          onGenerateRoute: (settings) {
            if (settings.name == 'splash') {
              return MaterialPageRoute(
                settings: settings,
                builder: (_) => widget.splash,
              );
            }
            return generateRoute(settings);
          },
        ),
      ),
    );
  }
}
