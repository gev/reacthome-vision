import 'package:flutter/widgets.dart';
import 'package:ui_kit/kit.dart';

Widget confirm(
  BuildContext context, {
  Widget? title,
  Widget? content,
  bool isDestructive = false,
  required String confirmLabel,
  required String cancelLabel,
}) => Kit.dialog.alert(
  title: title,
  content: content,
  actions: [
    Kit.dialog.action(
      label: cancelLabel,
      onPressed: () => Navigator.of(context).pop(false),
    ),
    Kit.dialog.action(
      label: confirmLabel,
      isDestructiveAction: isDestructive,
      onPressed: () => Navigator.of(context).pop(true),
    ),
  ],
);
