import 'package:flutter/cupertino.dart';

class AlertDialogMacOS extends StatelessWidget {
  final Widget? title;
  final Widget? content;
  final List<Widget> actions;

  const AlertDialogMacOS({
    this.title,
    this.content,
    required this.actions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: title,
      content: content,
      actions: actions,
    );
  }
}
