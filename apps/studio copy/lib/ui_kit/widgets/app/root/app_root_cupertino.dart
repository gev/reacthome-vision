import 'package:flutter/cupertino.dart';
import 'package:studio/ui/navigation.dart';
import 'package:studio/ui_kit/theme/theme_cupertino.dart';

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
