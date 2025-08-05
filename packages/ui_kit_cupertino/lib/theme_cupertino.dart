import 'package:flutter/cupertino.dart';
import 'package:ui_kit/theme.dart' as ui_kit;

class ThemeCupertino implements ui_kit.Theme {
  late final CupertinoThemeData _themeData;

  ThemeCupertino(BuildContext context) {
    _themeData = CupertinoTheme.of(context);
  }

  @override
  TextStyle get titleStyle => _themeData.textTheme.navLargeTitleTextStyle;

  @override
  Color get color => _themeData.textTheme.textStyle.color!;

  @override
  TextStyle get bodyStyle => _themeData.textTheme.textStyle;

  @override
  Color get backgroundColor => _themeData.scaffoldBackgroundColor;

  @override
  Color get primaryColor => _themeData.primaryColor;

  @override
  Color get secondaryColor => _themeData.primaryContrastingColor;
}

CupertinoThemeData makeCupertinoTheme(Color seedColor, Brightness brightness) =>
    CupertinoThemeData(
      primaryColor: seedColor,
      brightness: brightness,
      applyThemeToAll: true,
    );
