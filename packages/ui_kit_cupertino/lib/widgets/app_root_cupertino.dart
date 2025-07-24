import 'package:flutter/cupertino.dart';
import 'package:ui_kit/navigation.dart';
import 'package:ui_kit_cupertino/theme_cupertino.dart';

class AppRootCupertino extends StatelessWidget {
  final String title;
  final Color seedColor;
  final Navigation navigation;

  const AppRootCupertino({
    required this.title,
    required this.seedColor,
    required this.navigation,
    super.key,
  });

  @override
  Widget build(BuildContext context) => CupertinoApp(
    title: title,
    theme: makeCupertinoTheme(
      seedColor,
      MediaQuery.platformBrightnessOf(context),
    ),
    initialRoute: navigation.initialRoute,
    routes: navigation.routes,
  );
}
