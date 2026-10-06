import 'package:flutter/material.dart';
import 'package:glue/ir.dart';
import 'package:vision/glue/widgets/glue_app.dart';
import 'package:vision/screens/splash_screen.dart';
import 'package:vision/widgets/main_entry_point.dart';

class VisionApp extends StatelessWidget {
  final String _title;
  final Color? _seedColor;
  final DynamicSchemeVariant? _dynamicSchemeVariant;
  final VisualDensity? _visualDensity;

  const VisionApp({
    required this._title,
    this._seedColor,
    this._dynamicSchemeVariant,
    this._visualDensity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final args = IrObject({
      'title': toIr(_title),
      'seed-color': toIr(_seedColor),
      'dynamic-scheme-varian': toIr(_dynamicSchemeVariant),
      'visual-density': toIr(_visualDensity),
    });
    return GlueApp(
      title: _title,
      app: mainEntryPoint(args),
      splash: SplashScreen(title: _title, route: defaultRoute),
    );
  }
}
