import 'package:flow/make/core/home_factory.dart';
import 'package:flow/make/core/preferences_factory.dart';
import 'package:flow/ui/screens/splash_screen.dart';
import 'package:flutter/widgets.dart';

class SplashScreenFactory {
  SplashScreenFactory._();

  static Future<WidgetBuilder> make() async {
    final preferencesService = await PreferencesFactory.makePreferencesApi();
    final homeService = await HomeFactory.makeHomeApi();
    return (_) =>
        SplashScreen(preferencesApi: preferencesService, homeApi: homeService);
  }
}
