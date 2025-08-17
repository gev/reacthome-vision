import 'package:flutter/material.dart';

class CheckboxMaterial extends StatelessWidget {
  final bool value;
  final Function(bool?)? onChanged;

  const CheckboxMaterial({required this.value, this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return Checkbox(value: value, onChanged: onChanged);
  }
}
