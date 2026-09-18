import 'package:flutter/widgets.dart';

NavigatorState findNavigator(
  BuildContext context,
  bool rootNavigator,
  NavigatorState? targetNavigator,
) => rootNavigator
    ? Navigator.of(context, rootNavigator: true)
    : targetNavigator ?? Navigator.of(context);
