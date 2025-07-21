import 'package:flutter/widgets.dart';
import 'package:ui_kit/kit.dart';

Widget alert(
  BuildContext context, {
  Widget? title,
  Widget? content,
  required String actionLabel,
}) => Kit.dialog.alert(
  title: title,
  content: content,
  actions: [
    Kit.dialog.action(
      label: actionLabel,
      onPressed: () => Navigator.of(context).pop(false),
    ),
  ],
);
