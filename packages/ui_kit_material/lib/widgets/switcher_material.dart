import 'package:flutter/material.dart';

class SwitcherMaterial extends StatelessWidget {
  final bool value;
  final Function(bool)? onChanged;

  const SwitcherMaterial({required this.value, this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return Switch(value: value, onChanged: onChanged);
  }
}
