import 'package:flutter/material.dart';

class AlertDialogMaterial extends StatelessWidget {
  final Widget? title;
  final Widget? content;
  final List<Widget> actions;

  const AlertDialogMaterial({
    this.title,
    this.content,
    required this.actions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(title: title, content: content, actions: actions);
  }
}
