import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:yaru/yaru.dart';

class AppRootYaru extends StatelessWidget {
  final String title;
  final Color seedColor;
  final Navigation navigation;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final Iterable<Locale> supportedLocales;

  const AppRootYaru({
    required this.title,
    required this.seedColor,
    required this.navigation,
    this.localizationsDelegates,
    Iterable<Locale>? supportedLocales,
    super.key,
  }) : supportedLocales = supportedLocales ?? const [Locale('en', 'US')];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      themeMode: ThemeMode.system,
      theme: createYaruLightTheme(
        primaryColor: seedColor,
        lightBaseColor: Colors.transparent,
      ),
      darkTheme: createYaruDarkTheme(
        primaryColor: seedColor,
        darkBaseColor: Colors.transparent,
      ),
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
      initialRoute: navigation.initialRoute,
      routes: navigation.routes,
    );
  }
}
