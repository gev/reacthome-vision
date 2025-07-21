import 'package:flutter/material.dart';
import 'package:ui_kit/platform.dart';
import 'package:ui_kit/theme/theme.dart';
import 'package:ui_kit/theme/theme_cupertino.dart';
import 'package:ui_kit/theme/theme_material.dart';

class Theme {
  Theme._();

  static ThemeContainer of(BuildContext context) => selectPlatform(
    cupertino: ThemeCupertino(context),
    material: ThemeMaterial(context),
  );
}
