import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/widgets/glue_app_base_state.dart';
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

class _GlueAppState extends GlueAppBaseState<GlueApp>
    with WidgetsBindingObserver {
  Locale _currentLocale = WidgetsBinding.instance.platformDispatcher.locale;

  @override
  Ir get app => widget.app;

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
      onGenerateRoute: generateRoute,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
