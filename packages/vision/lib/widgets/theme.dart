import 'package:flutter/material.dart';
import 'package:vision/glue/app.dart';

ThemeData? makeTheme({
  required App app,
  required Brightness brightness,
  VisualDensity? visualDensity,
}) {
  return ThemeData(
    colorScheme: .fromSeed(
      brightness: brightness,
      seedColor: app.seedColor ?? Color(0xff6200ee),
      dynamicSchemeVariant:
          app.dynamicSchemeVariant ?? DynamicSchemeVariant.tonalSpot,
    ),
    visualDensity: app.visualDensity ?? visualDensity,
  );
}
