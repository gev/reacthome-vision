import 'package:flutter/material.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/widgets/glue_app.dart';
import 'package:vision/screens/splash_screen.dart';

class VisionApp extends StatelessWidget {
  final String title;

  VisionApp({required this.title, super.key});

  // (
  //   (import main)
  //   main
  // )
  final _main = IrList([
    IrList([IrSymbol('import'), IrSymbol('main')]),
    IrSymbol('main'),
  ]);

  @override
  Widget build(BuildContext context) {
    return GlueApp(
      title: title,
      app: _main,
      splash: SplashScreen(title: title),
    );
  }
}
