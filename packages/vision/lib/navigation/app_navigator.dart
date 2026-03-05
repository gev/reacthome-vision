import 'package:flutter/material.dart';

class AppNavigator {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Future<T?> push<T>(Route<T> route) {
    return navigatorKey.currentState!.push(route);
  }

  static void pop<T>([T? result]) {
    navigatorKey.currentState!.pop(result);
  }

  static Future<T?> pushReplacement<T>(Route<T> route) {
    return navigatorKey.currentState!.pushReplacement(route);
  }

  static void popUntil(RoutePredicate predicate) {
    navigatorKey.currentState!.popUntil(predicate);
  }

  static bool canPop() {
    return navigatorKey.currentState!.canPop();
  }
}
