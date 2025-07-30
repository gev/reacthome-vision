import 'package:flutter/cupertino.dart';

class DialogActionMacOS extends StatelessWidget {
  final String label;
  final bool isDefaultAction;
  final bool isDestructiveAction;
  final void Function()? onPressed;

  const DialogActionMacOS({
    required this.label,
    this.isDefaultAction = false,
    this.isDestructiveAction = false,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoDialogAction(
      onPressed: onPressed,
      isDefaultAction: isDefaultAction,
      isDestructiveAction: isDestructiveAction,
      child: Text(label),
    );
  }
}
