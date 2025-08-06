import 'package:flutter/widgets.dart';
import 'package:macos_ui/macos_ui.dart';

class ButtonFilledMacos extends StatelessWidget {
  final String label;
  final void Function()? onPressed;

  const ButtonFilledMacos({required this.label, this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return PushButton(
      controlSize: ControlSize.regular,
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
