import 'package:flutter/widgets.dart';
import 'package:macos_ui/macos_ui.dart';

class SwitcherMacos extends StatelessWidget {
  final bool value;
  final Function(bool)? onChanged;

  const SwitcherMacos({required this.value, this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return MacosSwitch(value: value, onChanged: onChanged);
  }
}
