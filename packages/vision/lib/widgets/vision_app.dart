import 'package:flutter/material.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/widgets/glue_app.dart';
import 'package:vision/screens/splash_screen.dart';
import 'package:vision/widgets/main_entry_point.dart';

class VisionApp extends StatelessWidget {
  final String title;
  final Ir args;

  const VisionApp({required this.title, required this.args, super.key});

  @override
  Widget build(BuildContext context) {
    return GlueApp(
      title: title,
      app: mainEntryPoint(args),
      splash: SplashScreen(title: title, route: defaultRoute),
    );
  }
}
