import 'package:flutter/widgets.dart';
import 'package:navigation/navigation.dart';

class NavigationRouteNames {
  static const splash = '/';
  static const iconic = 'iconic';
}

class NavigationLab implements Navigation {
  final WidgetBuilder splash;
  final WidgetBuilder iconic;

  const NavigationLab({required this.splash, required this.iconic});

  @override
  String get initialRoute => NavigationRouteNames.splash;

  @override
  Map<String, WidgetBuilder> get routes => ({
    NavigationRouteNames.splash: splash,
    NavigationRouteNames.iconic: iconic,
  });
}
