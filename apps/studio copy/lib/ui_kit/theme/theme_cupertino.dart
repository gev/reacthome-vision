import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studio/ui_kit/theme/theme.dart';
import 'package:studio/ui_kit/theme/theme_material.dart';

class ThemeCupertino implements ThemeContainer {
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
    MaterialBasedCupertinoThemeData(
      materialTheme: makeMaterialTheme(
        seedColor,
        brightness,
        CupertinoThemeData(
          brightness: brightness,
          textTheme: const CupertinoTextThemeData(),
          barBackgroundColor: CupertinoColors.systemBackground,
          scaffoldBackgroundColor: CupertinoColors.systemGroupedBackground,
          applyThemeToAll: true,
        ),
      ),
    );
