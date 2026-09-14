import 'package:flutter/material.dart';
import 'package:vision/glue/widgets/glue_applet.dart';
import 'package:vision/screens/splash_screen.dart';
import 'package:vision/widgets/main_entry_point.dart';

class VisionApplet extends StatelessWidget {
  final String title;

  const VisionApplet({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return GlueApplet(
      title: title,
      app: mainEntryPoint,
      splash: SplashScreen(title: title, route: 'index'),
    );
  }
}
