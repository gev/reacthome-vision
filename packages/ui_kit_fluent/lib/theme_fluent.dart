import 'package:fluent_ui/fluent_ui.dart';
import 'package:ui_kit/theme.dart' as ui_kit;

class ThemeFluent implements ui_kit.Theme {
  late final FluentThemeData _themeData;

  ThemeFluent(BuildContext context) {
    _themeData = FluentTheme.of(context);
  }

  @override
  TextStyle get titleStyle => _themeData.typography.titleLarge!;

  @override
  Color get color => _themeData.cardColor;

  @override
  TextStyle get bodyStyle => _themeData.typography.body!;

  @override
  Color get backgroundColor => _themeData.scaffoldBackgroundColor;

  @override
  Color get primaryColor => _themeData.activeColor;

  @override
  Color get secondaryColor => _themeData.accentColor;
}

FluentThemeData makeFluentTheme(Color seedColor, Brightness brightness) =>
    FluentThemeData(brightness: brightness);
