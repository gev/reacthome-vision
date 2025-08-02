import 'package:flutter/widgets.dart';
import 'package:macos_ui/macos_ui.dart';

class TextFieldMacOS extends StatelessWidget {
  final TextEditingController? controller;
  final String? placeholder;
  final bool autofocus;

  const TextFieldMacOS({
    this.controller,
    this.placeholder,
    this.autofocus = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MacosTextField(
      controller: controller,
      placeholder: placeholder,
      autofocus: autofocus,
    );
  }
}
