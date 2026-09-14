import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/app.dart';
import 'package:vision/glue/widgets/glue_route.dart';
import 'package:vision/glue/widgets/glue_runtime_mixin.dart';
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

class _GlueAppState extends State<GlueApp>
    with WidgetsBindingObserver, GlueRuntimeMixin<GlueApp> {
  Locale _currentLocale = WidgetsBinding.instance.platformDispatcher.locale;

  @override
  Ir get widgetApp => widget.app;

  @override
  void updateApp(App newApp) => setState(() => cachedApp = newApp);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    super.didChangeLocales(locales);
    setState(() {
      _currentLocale = WidgetsBinding.instance.platformDispatcher.locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: widget.title,
      key: ValueKey((_currentLocale, cachedApp)),
      themeMode: ThemeMode.system,
      theme: makeTheme(cachedApp, Brightness.light),
      darkTheme: makeTheme(cachedApp, Brightness.dark),
      locale: _currentLocale,
      supportedLocales: WidgetsBinding.instance.platformDispatcher.locales,
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: widget.splash,
      onGenerateRoute: (settings) => generateGlueRoute(
        settings,
        cachedApp: cachedApp,
        scope: scope,
        context: context,
        splashWidget: widget.splash,
      ),
    );
  }

  @override
  void didUpdateWidget(GlueApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    didUpdateWidgetRuntime();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    disposeRuntime();
    super.dispose();
  }
}
