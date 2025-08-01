import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';

class SwitcherMacOS extends StatelessWidget {
  final bool value;
  final Function(bool)? onChanged;

  const SwitcherMacOS({required this.value, this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return MacosSwitch(value: value, onChanged: onChanged);
  }
}
