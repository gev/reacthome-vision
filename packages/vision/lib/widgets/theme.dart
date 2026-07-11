import 'package:flutter/material.dart';
import 'package:vision/glue/app.dart';

ThemeData? makeTheme(App app, Brightness brightness) {
  final seedColor = app.seedColor;
  return ThemeData(
    colorScheme: .fromSeed(
      brightness: brightness,
      seedColor: seedColor ?? Color(0xff6200ee),
      dynamicSchemeVariant:
          app.dynamicSchemeVariant ?? DynamicSchemeVariant.tonalSpot,
    ),
  );
}
