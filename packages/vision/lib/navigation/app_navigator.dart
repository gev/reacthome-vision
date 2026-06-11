import 'package:flutter/material.dart';

class AppNavigator {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Future<T?> push<T>(String route) {
    return navigatorKey.currentState!.pushNamed(route);
  }

  static void pop<T>([T? result]) {
    navigatorKey.currentState!.pop(result);
  }

  static Future<T?> pushReplacement<T>(String route) {
    return navigatorKey.currentState!.pushReplacementNamed(route);
  }

  static void popUntil(RoutePredicate predicate) {
    navigatorKey.currentState!.popUntil(predicate);
  }

  static bool canPop() {
    return navigatorKey.currentState!.canPop();
  }
}
