import 'package:flutter/widgets.dart';
import 'package:ui_kit/widgets.dart';

Widget alert(
  BuildContext context, {
  Widget? title,
  Widget? content,
  required String actionLabel,
}) => UI.AlertDialog(
  title: title,
  content: content,
  actions: [
    UI.DialogAction(
      label: actionLabel,
      onPressed: () => Navigator.of(context).pop(false),
    ),
  ],
);
