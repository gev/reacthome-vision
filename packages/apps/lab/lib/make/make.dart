import 'package:flutter/widgets.dart';
import 'package:lab/make/config.dart';
import 'package:lab/make/screens/splash_screen_factory.dart';
import 'package:lab/make/screens/welcome_screen_factory.dart';
import 'package:lab/ui/navigation.dart';
import 'package:lab/ui/views/app.dart';

Future<Widget> make() async {
  return App(
    navigation: const NavigationLab(
      splash: SplashScreenFactory.make,
      welcome: WelcomeScreenFactory.make,
    ),
    seedColor: Config.theme.seedColor,
  );
}
