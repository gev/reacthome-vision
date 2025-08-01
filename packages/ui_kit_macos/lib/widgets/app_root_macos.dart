import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:navigation/navigation.dart';

class AppRootMacOS extends StatelessWidget {
  final String title;
  final Color seedColor;
  final Navigation navigation;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final Iterable<Locale> supportedLocales;

  const AppRootMacOS({
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
        theme: MacosThemeData.light(
          accentColor: accentColor,
          isMainWindow: false,
        ), // makeMacOSTheme(seedColor, accentColor, Brightness.light),
        darkTheme: MacosThemeData.dark(
          accentColor: accentColor,
          isMainWindow: false,
        ), // makeMacOSTheme(seedColor, accentColor, Brightness.dark),
        localizationsDelegates: localizationsDelegates,
        supportedLocales: supportedLocales,
        initialRoute: navigation.initialRoute,
        routes: navigation.routes,
      );
    },
  );
}
