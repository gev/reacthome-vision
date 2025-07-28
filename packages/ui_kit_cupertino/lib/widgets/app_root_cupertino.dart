import 'package:flutter/cupertino.dart';
import 'package:navigation/navigation.dart';
import 'package:ui_kit_cupertino/theme_cupertino.dart';

class AppRootCupertino extends StatelessWidget {
  final String title;
  final Color seedColor;
  final Navigation navigation;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final Iterable<Locale> supportedLocales;

  const AppRootCupertino({
    required this.title,
    required this.seedColor,
    required this.navigation,
    this.localizationsDelegates,
    Iterable<Locale>? supportedLocales,
    super.key,
  }) : supportedLocales = supportedLocales ?? const [Locale('en', 'US')];

  @override
  Widget build(BuildContext context) => CupertinoApp(
    title: title,
    theme: makeCupertinoTheme(
      seedColor,
      MediaQuery.platformBrightnessOf(context),
    ),
    localizationsDelegates: localizationsDelegates,
    supportedLocales: supportedLocales,
    initialRoute: navigation.initialRoute,
    routes: navigation.routes,
  );
}
