import 'package:flutter/widgets.dart';
import 'package:navigation/navigation.dart';

class NavigationRouteNames {
  static const splash = '/';
  static const welcome = 'welcome';
}

class NavigationStudio implements Navigation {
  final WidgetBuilder splash;
  final WidgetBuilder welcome;

  const NavigationStudio({required this.splash, required this.welcome});

  @override
  String get initialRoute => NavigationRouteNames.splash;

  @override
  Map<String, WidgetBuilder> get routes => ({
    NavigationRouteNames.splash: splash,
    NavigationRouteNames.welcome: welcome,
  });
}
