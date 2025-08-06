import 'package:flutter/widgets.dart';
import 'package:macos_ui/macos_ui.dart';

class AlertDialogMacos extends StatelessWidget {
  final Widget? title;
  final Widget? content;
  final List<Widget> actions;

  const AlertDialogMacos({
    this.title,
    this.content,
    required this.actions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MacosAlertDialog(
      title: title!,
      message: content!,
      primaryButton: actions[0] as PushButton,
      secondaryButton: actions[1] as PushButton,
      appIcon: const SizedBox(),
    );
  }
}
