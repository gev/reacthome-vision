import 'package:flutter/material.dart';
import 'package:ui_kit/navigation.dart';
import 'package:ui_kit_material/theme_material.dart';

class AppRootMaterial extends StatelessWidget {
  final String title;
  final Color seedColor;
  final Navigation navigation;

  const AppRootMaterial({
    required this.title,
    required this.seedColor,
    required this.navigation,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      themeMode: ThemeMode.system,
      theme: makeMaterialTheme(seedColor, Brightness.light),
      darkTheme: makeMaterialTheme(seedColor, Brightness.dark),
      initialRoute: navigation.initialRoute,
      routes: navigation.routes,
    );
  }
}
