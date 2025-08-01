import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:ui_kit/theme.dart' as ui_kit;

class ThemeMacOS implements ui_kit.Theme {
  late final CupertinoThemeData _themeData;

  ThemeMacOS(BuildContext context) {
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

MacosThemeData makeMacOSTheme(
  Color seedColor,
  AccentColor? accentColor,
  Brightness brightness,
) => MacosThemeData(
  // primaryColor: seedColor,
  accentColor: accentColor,
  brightness: brightness,
);
