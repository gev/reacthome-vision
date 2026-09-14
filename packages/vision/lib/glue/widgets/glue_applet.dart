import 'package:flutter/material.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/app.dart';
import 'package:vision/glue/widgets/glue_route.dart';
import 'package:vision/glue/widgets/glue_runtime_mixin.dart';
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

class _GlueAppletState extends State<GlueApplet>
    with GlueRuntimeMixin<GlueApplet> {
  @override
  Ir get widgetApp => widget.app;

  @override
  void updateApp(App newApp) => setState(() => cachedApp = newApp);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeData = makeTheme(cachedApp, theme.brightness);
    return Theme(
      data: themeData ?? theme,
      child: Material(
        child: Navigator(
          initialRoute: 'splash',
          onGenerateRoute: (settings) => generateGlueRoute(
            settings,
            cachedApp: cachedApp,
            scope: scope,
            context: context,
            splashWidget: widget.splash,
          ),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(GlueApplet oldWidget) {
    super.didUpdateWidget(oldWidget);
    didUpdateWidgetRuntime();
  }

  @override
  void dispose() {
    disposeRuntime();
    super.dispose();
  }
}
