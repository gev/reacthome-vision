import 'package:flutter/material.dart';
import 'package:vision/splash.dart';
import 'package:vision/theme.dart';

class VisionApp extends StatelessWidget {
  final String title;
  const VisionApp({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      themeMode: ThemeMode.system,
      theme: makeTheme(Colors.blue, Brightness.light),
      darkTheme: makeTheme(Colors.blue, Brightness.dark),
      home: Splash(title),
    );
  }
}
