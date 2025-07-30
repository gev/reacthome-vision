import 'package:flutter/cupertino.dart';

Future<T?> showDialogMacOS<T>(
  BuildContext context, {
  required WidgetBuilder builder,
}) => showCupertinoDialog(
  context: context,
  builder: builder,
  barrierDismissible: true,
);
