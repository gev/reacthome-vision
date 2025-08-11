import 'package:flutter/material.dart';
import 'package:ui_kit/theme.dart' as ui_kit;
import 'package:yaru/yaru.dart';

class ThemeYaru implements ui_kit.Theme {
  late final ThemeData _themeData;

  ThemeYaru(BuildContext context) {
    _themeData = YaruTheme.of(context).theme!;
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
