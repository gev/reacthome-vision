import 'package:flutter/material.dart';

ThemeData makeTheme(Color seedColor, Brightness brightness) => ThemeData(
  colorScheme: ColorScheme.fromSeed(
    brightness: brightness,
    seedColor: seedColor,
    dynamicSchemeVariant: DynamicSchemeVariant.vibrant,
  ),
);
