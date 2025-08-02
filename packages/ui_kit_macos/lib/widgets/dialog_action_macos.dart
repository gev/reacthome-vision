import 'package:flutter/widgets.dart';
import 'package:macos_ui/macos_ui.dart';

class DialogActionMacOS extends PushButton {
  final String label;

  DialogActionMacOS({
    required this.label,
    bool isDefaultAction = false,
    bool isDestructiveAction = false,
    super.onPressed,
    super.key,
  }) : super(
         child: Text(label),
         controlSize: ControlSize.large,
         secondary: !isDestructiveAction,
       );
}
