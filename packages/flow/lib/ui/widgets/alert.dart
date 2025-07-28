import 'package:flutter/widgets.dart';
import 'package:ui_kit/widgets.dart';

Widget alert(
  BuildContext context, {
  Widget? title,
  Widget? content,
  required String actionLabel,
}) => AlertDialog(
  title: title,
  content: content,
  actions: [
    DialogAction(
      label: actionLabel,
      onPressed: () => Navigator.of(context).pop(false),
    ),
  ],
);
