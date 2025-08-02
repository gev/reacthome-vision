import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/theme.dart' as ui_kit;

class ThemeMaterial implements ui_kit.Theme {
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

FluentThemeData makeFluentTheme(Color seedColor, Brightness brightness) =>
    FluentThemeData(brightness: brightness);
