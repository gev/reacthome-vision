import 'package:flutter/widgets.dart';
import 'package:macos_ui/macos_ui.dart';

Future<T?> showDialogMacOS<T>(
  BuildContext context, {
  required WidgetBuilder builder,
}) => showMacosAlertDialog(
  context: context,
  builder: builder,
  barrierDismissible: true,
);
