import 'package:flutter/material.dart';
import 'package:studio/ui_kit/theme/theme.dart';
import 'package:studio/ui_kit/theme/theme_cupertino.dart';
import 'package:studio/ui_kit/theme/theme_material.dart';
import 'package:studio/util/platform.dart';

class Theme {
  Theme._();

  static ThemeContainer of(BuildContext context) => selectPlatform(
    cupertino: ThemeCupertino(context),
    material: ThemeMaterial(context),
  );
}
