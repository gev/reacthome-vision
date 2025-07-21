import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studio/ui_kit/theme/theme.dart';

class ThemeMaterial implements ThemeContainer {
  late final ThemeData _themeData;

  ThemeMaterial(BuildContext context) {
    _themeData = Theme.of(context);
  }

  @override
  TextStyle get titleStyle => _themeData.textTheme.headlineLarge!;

  @override
  Color get color => _themeData.colorScheme.onSurface;

  @override
  TextStyle get bodyStyle => _themeData.textTheme.bodyMedium!;

  @override
  Color get backgroundColor => _themeData.colorScheme.surface;

  @override
  Color get primaryColor => _themeData.colorScheme.primary;

  @override
  Color get secondaryColor => _themeData.colorScheme.secondary;
}

ThemeData makeMaterialTheme(
  Color seedColor,
  Brightness brightness, [
  NoDefaultCupertinoThemeData? cupertinoOverrideTheme,
]) => ThemeData(
  colorScheme: ColorScheme.fromSeed(
    brightness: brightness,
    seedColor: seedColor,
    dynamicSchemeVariant: DynamicSchemeVariant.vibrant,
  ),
  cupertinoOverrideTheme: cupertinoOverrideTheme,
);
