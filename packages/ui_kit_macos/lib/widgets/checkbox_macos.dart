import 'package:flutter/widgets.dart';
import 'package:macos_ui/macos_ui.dart';

class CheckboxMacos extends StatelessWidget {
  final bool value;
  final Function(bool?)? onChanged;

  const CheckboxMacos({required this.value, this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return MacosCheckbox(value: value, onChanged: onChanged);
  }
}
