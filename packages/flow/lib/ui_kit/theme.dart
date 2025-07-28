import 'package:flow/ui_kit/theme/theme.dart';
import 'package:flow/ui_kit/theme/theme_cupertino.dart';
import 'package:flow/ui_kit/theme/theme_material.dart';
import 'package:flow/util/platform.dart';
import 'package:flutter/widgets.dart';

class Theme {
  Theme._();

  static ThemeContainer of(BuildContext context) => selectPlatform(
    cupertino: ThemeCupertino(context),
    material: ThemeMaterial(context),
  );
}
