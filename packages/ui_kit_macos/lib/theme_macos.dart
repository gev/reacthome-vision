import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:ui_kit/theme.dart' as ui_kit;

class ThemeMacOS implements ui_kit.Theme {
  late final MacosThemeData _themeData;

  ThemeMacOS(BuildContext context) {
    _themeData = MacosTheme.of(context);
  }

  @override
  TextStyle get titleStyle => _themeData.typography.largeTitle;

  @override
  Color get color => _themeData.typography.body.color!;

  @override
  TextStyle get bodyStyle => _themeData.typography.body;

  @override
  Color get backgroundColor => _themeData.canvasColor;

  @override
  Color get primaryColor => _themeData.primaryColor;

  @override
  Color get secondaryColor => _themeData.dividerColor;
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
