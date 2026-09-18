import 'package:flutter/material.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/widgets/glue_applet.dart';
import 'package:vision/screens/splash_screen.dart';
import 'package:vision/widgets/main_entry_point.dart';

class VisionApplet extends StatelessWidget {
  final String title;
  final Ir args;

  const VisionApplet({required this.title, required this.args, super.key});

  @override
  Widget build(BuildContext context) {
    return GlueApplet(
      app: mainEntryPoint(args),
      splash: SplashScreen(title: title, route: defaultRoute),
    );
  }
}
