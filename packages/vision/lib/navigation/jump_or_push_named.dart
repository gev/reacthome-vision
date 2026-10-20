import 'package:flutter/widgets.dart';
import 'package:glue/ir.dart';
import 'package:vision/navigation/multi_navigator_tracker.dart';

void jumpOrPushNamed<T>(
  NavigatorState navigator,
  String route, {
  IrObject? arguments,
}) {
  final existingRoute = MultiNavigatorTracker.findExistingRoute(
    navigator,
    route,
    arguments,
  );

  if (existingRoute != null) {
    navigator.popUntil((r) => r == existingRoute);
  } else {
    navigator.pushNamed<T>(route, arguments: arguments);
  }
}
