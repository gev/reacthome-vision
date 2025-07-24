import 'package:flutter/material.dart';

class DialogActionMaterial extends StatelessWidget {
  final String label;
  final bool isDefaultAction;
  final bool isDestructiveAction;
  final void Function()? onPressed;

  const DialogActionMaterial({
    required this.label,
    this.isDefaultAction = false,
    this.isDestructiveAction = false,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed, child: Text(label));
  }
}
