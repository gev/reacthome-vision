import 'package:flutter/material.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue_flutter/glue_flutter.dart';
import 'package:vision/glue/lib/widgets/current_theme.dart';

final theme = IrNativeFunc((props) => _createTheme(WidgetProperties(props)));

Eval<Ir> _createTheme(WidgetProperties properties) {
  final colorScheme = properties.getValue<ColorScheme>('color-scheme');
  if (colorScheme == null) {
    return throwError(wrongArgumentType(['`color-scheme` property required']));
  }
  final theme = ThemeData.from(
    colorScheme: colorScheme,
    textTheme: properties.getValue('text-theme'),
  );

  return Eval.pure(themeData(theme));
}
