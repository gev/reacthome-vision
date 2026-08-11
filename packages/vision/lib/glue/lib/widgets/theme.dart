import 'package:flutter/material.dart';
import 'package:glue/error.dart';
import 'package:glue/eval.dart';
import 'package:glue/ir.dart';
import 'package:glue_flutter/glue_flutter.dart';
import 'package:vision/glue/lib/widgets/current_theme.dart';

final theme = IrNativeFunc(
  (props) => switch (props) {
    IrObject(:final properties) => _createTheme(
      WidgetProperties(properties.unlock),
    ),
    _ => Eval.pure(themeData(ThemeData(useMaterial3: true))),
  },
);

Eval<Ir> _createTheme(WidgetProperties properties) {
  final colorScheme = properties.getValue<ColorScheme>('color-scheme');
  if (colorScheme == null) {
    return throwError(wrongArgumentType(['`color-scheme` property required']));
  }
  final themeData = ThemeData.from(
    useMaterial3: true,
    colorScheme: colorScheme,
    textTheme: properties.getValue('text-theme'),
  );

  return Eval.pure(IrNativeValue(Value(themeData)));
}
