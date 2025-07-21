import 'package:flutter/cupertino.dart';
import 'package:ui_kit/navigation.dart';
import 'package:ui_kit_cupertino/theme_cupertino.dart';

class AppRootCupertino {
  static Widget make(
    BuildContext context, {
    required String title,
    required Color seedColor,
    required Navigation navigation,
  }) => CupertinoApp(
    title: title,
    theme: makeCupertinoTheme(
      seedColor,
      MediaQuery.platformBrightnessOf(context),
    ),
    initialRoute: navigation.initialRoute,
    routes: navigation.routes,
  );
}
