import 'package:flutter/material.dart';
import 'package:vision/glue/widgets/glue_app.dart';
import 'package:vision/screens/splash_screen.dart';
import 'package:vision/widgets/main_entry_point.dart';

class VisionApp extends StatelessWidget {
  final String title;

  const VisionApp({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return GlueApp(
      title: title,
      app: mainEntryPoint,
      splash: SplashScreen(title: title, route: defaultRoute),
    );
  }
}
