import 'package:flutter/widgets.dart';

typedef ThemeBuilder = Theme Function(BuildContext context);

abstract interface class Theme {
  TextStyle get titleStyle;
  TextStyle get bodyStyle;
  Color get color;
  Color get backgroundColor;
  Color get primaryColor;
  Color get secondaryColor;
}
