import 'package:flutter/widgets.dart';

class NavigationRouteNames {
  static const splash = 'splash';
  static const welcome = '/';
}

class Navigation {
  final WidgetBuilder splash;
  final WidgetBuilder welcome;

  const Navigation({required this.splash, required this.welcome});

  String get initialRoute => NavigationRouteNames.welcome;

  Map<String, WidgetBuilder> get routes => ({
    NavigationRouteNames.splash: splash,
    NavigationRouteNames.welcome: welcome,
  });
}
