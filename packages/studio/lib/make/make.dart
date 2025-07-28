import 'package:flutter/widgets.dart';
import 'package:studio/make/config.dart';
import 'package:studio/make/screens/splash_screen_factory.dart';
import 'package:studio/make/screens/welcome_screen_factory.dart';
import 'package:studio/ui/views/app.dart';
import 'package:ui_kit/navigation.dart';

Future<Widget> make() async {
  return App(
    navigation: const Navigation(
      splash: SplashScreenFactory.make,
      welcome: WelcomeScreenFactory.make,
    ),
    seedColor: Config.theme.seedColor,
  );
}
