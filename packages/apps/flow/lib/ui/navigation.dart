import 'package:flutter/widgets.dart';
import 'package:navigation/navigation.dart';

class NavigationRouteNames {
  static const home = 'home';
  static const splash = '/';
  static const welcome = 'welcome';
  static const discovery = 'discovery';
  static const addHome = 'addHome';
  static const myHomes = 'myHomes';
}

class FlowNavigation implements Navigation {
  final WidgetBuilder home;
  final WidgetBuilder splash;
  final WidgetBuilder welcome;
  final WidgetBuilder discovery;
  final WidgetBuilder addHome;
  final WidgetBuilder myHomes;

  const FlowNavigation({
    required this.home,
    required this.splash,
    required this.welcome,
    required this.discovery,
    required this.addHome,
    required this.myHomes,
  });

  @override
  String get initialRoute => NavigationRouteNames.splash;

  @override
  Map<String, WidgetBuilder> get routes => ({
    NavigationRouteNames.home: home,
    NavigationRouteNames.splash: splash,
    NavigationRouteNames.welcome: welcome,
    NavigationRouteNames.discovery: discovery,
    NavigationRouteNames.addHome: addHome,
    NavigationRouteNames.myHomes: myHomes,
  });
}
