import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:navigation/navigation.dart';
import 'package:ui_kit_macos/theme_macos.dart';

class AppRootMacos extends StatelessWidget {
  final String title;
  final Color seedColor;
  final Navigation navigation;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final Iterable<Locale> supportedLocales;

  const AppRootMacos({
    required this.title,
    required this.seedColor,
    required this.navigation,
    this.localizationsDelegates,
    Iterable<Locale>? supportedLocales,
    super.key,
  }) : supportedLocales = supportedLocales ?? const [Locale('en', 'US')];

  @override
  Widget build(BuildContext context) => StreamBuilder(
    stream: AccentColorListener.instance.onChanged,
    builder: (context, _) {
      final AccentColor? accentColor =
          AccentColorListener.instance.currentAccentColor;
      return MacosApp(
        title: title,
        theme: makeMacOSTheme(seedColor, accentColor, Brightness.light),
        darkTheme: makeMacOSTheme(seedColor, accentColor, Brightness.dark),
        localizationsDelegates: localizationsDelegates,
        supportedLocales: supportedLocales,
        initialRoute: navigation.initialRoute,
        routes: navigation.routes,
      );
    },
  );
}
