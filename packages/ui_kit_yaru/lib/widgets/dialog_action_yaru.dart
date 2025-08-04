import 'package:flutter/material.dart';

class DialogActionYaru extends StatelessWidget {
  final String label;
  final bool isDefaultAction;
  final bool isDestructiveAction;
  final void Function()? onPressed;

  const DialogActionYaru({
    required this.label,
    this.isDefaultAction = false,
    this.isDestructiveAction = false,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return isDestructiveAction
        ? ElevatedButton(onPressed: onPressed, child: Text(label))
        : FilledButton(onPressed: onPressed, child: Text(label));
  }
}
