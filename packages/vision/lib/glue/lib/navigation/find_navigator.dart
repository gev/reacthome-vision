import 'package:flutter/widgets.dart';

NavigatorState? findNavigator(
  BuildContext? context,
  bool rootNavigator,
  NavigatorState? targetNavigator,
) {
  if (rootNavigator) {
    if (context != null) {
      return Navigator.of(context, rootNavigator: true);
    }
  } else if (targetNavigator != null) {
    return targetNavigator;
  } else if (context != null) {
    return Navigator.of(context);
  }
  return null;
}
