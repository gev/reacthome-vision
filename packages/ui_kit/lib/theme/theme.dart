import 'package:flutter/widgets.dart';

abstract interface class ThemeContainer {
  TextStyle get titleStyle;
  TextStyle get bodyStyle;
  Color get color;
  Color get backgroundColor;
  Color get primaryColor;
  Color get secondaryColor;
}
