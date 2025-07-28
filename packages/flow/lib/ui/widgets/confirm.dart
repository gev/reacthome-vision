import 'package:flutter/widgets.dart';
import 'package:ui_kit/widgets.dart';

Widget confirm(
  BuildContext context, {
  Widget? title,
  Widget? content,
  bool isDestructive = false,
  required String confirmLabel,
  required String cancelLabel,
}) => AlertDialog(
  title: title,
  content: content,
  actions: [
    DialogAction(
      label: cancelLabel,
      onPressed: () => Navigator.of(context).pop(false),
    ),
    DialogAction(
      label: confirmLabel,
      isDestructiveAction: isDestructive,
      onPressed: () => Navigator.of(context).pop(true),
    ),
  ],
);
