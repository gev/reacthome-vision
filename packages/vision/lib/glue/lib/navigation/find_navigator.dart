import 'package:flutter/widgets.dart';

NavigatorState findNavigator(
  BuildContext context,
  bool rootNavigator,
  NavigatorState? target,
) => rootNavigator
    ? Navigator.of(context, rootNavigator: true)
    : target ?? Navigator.of(context);
