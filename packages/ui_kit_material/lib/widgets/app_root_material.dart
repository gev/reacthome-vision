import 'package:flutter/material.dart';
import 'package:ui_kit/navigation.dart';
import 'package:ui_kit_material/theme_material.dart';

class AppRootMaterial {
  static Widget make(
    BuildContext context, {
    required String title,
    required Color seedColor,
    required Navigation navigation,
  }) => MaterialApp(
    title: title,
    themeMode: ThemeMode.system,
    theme: makeMaterialTheme(seedColor, Brightness.light),
    darkTheme: makeMaterialTheme(seedColor, Brightness.dark),
    initialRoute: navigation.initialRoute,
    routes: navigation.routes,
  );
}
