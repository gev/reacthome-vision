import 'package:fluent_ui/fluent_ui.dart';
import 'package:navigation/navigation.dart';
import 'package:ui_kit_fluent/theme_fluent.dart';

class AppRootFluent extends StatelessWidget {
  final String title;
  final Color seedColor;
  final Navigation navigation;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final Iterable<Locale> supportedLocales;

  const AppRootFluent({
    required this.title,
    required this.seedColor,
    required this.navigation,
    this.localizationsDelegates,
    Iterable<Locale>? supportedLocales,
    super.key,
  }) : supportedLocales = supportedLocales ?? const [Locale('en', 'US')];

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: title,
      themeMode: ThemeMode.system,
      theme: makeFluentTheme(seedColor, Brightness.light),
      darkTheme: makeFluentTheme(seedColor, Brightness.dark),
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
      initialRoute: navigation.initialRoute,
      routes: navigation.routes,
    );
  }
}
