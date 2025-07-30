import 'package:flutter/cupertino.dart';

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
    return CupertinoTextField(
      controller: controller,
      placeholder: placeholder,
      autofocus: autofocus,
    );
  }
}
