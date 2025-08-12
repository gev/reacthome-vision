import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:ui_kit/theme.dart' as ui_kit;

class ThemeMacos implements ui_kit.Theme {
  late final MacosThemeData _themeMacos;
  late final CupertinoThemeData _themeCupertino;

  ThemeMacos(BuildContext context) {
    _themeMacos = MacosTheme.of(context);
    _themeCupertino = CupertinoTheme.of(context);
  }

  @override
  TextStyle get titleStyle => _themeMacos.typography.largeTitle;

  @override
  Color get color => _themeMacos.typography.body.color!;

  @override
  TextStyle get bodyStyle => _themeMacos.typography.body;

  @override
  Color get backgroundColor => _themeCupertino.barBackgroundColor;

  @override
  Color get primaryColor => _themeMacos.primaryColor;

  @override
  Color get secondaryColor => _themeMacos.dividerColor;
}

MacosThemeData makeMacOSTheme(
  Color seedColor,
  AccentColor? accentColor,
  Brightness brightness,
) => MacosThemeData(
  // primaryColor: seedColor,
  accentColor: accentColor,
  brightness: brightness,
  canvasColor: MacosColors.transparent,
);
