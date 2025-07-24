import 'package:flutter/material.dart';

class TextFieldMaterial extends StatelessWidget {
  final TextEditingController? controller;
  final String? placeholder;
  final bool autofocus;

  const TextFieldMaterial({
    this.controller,
    this.placeholder,
    this.autofocus = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autofocus: autofocus,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        isDense: true,
        hintText: placeholder,
      ),
    );
  }
}
