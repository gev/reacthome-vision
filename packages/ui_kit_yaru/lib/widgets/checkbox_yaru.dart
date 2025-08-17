import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

class CheckboxYaru extends StatelessWidget {
  final bool value;
  final Function(bool?)? onChanged;

  const CheckboxYaru({required this.value, this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return YaruCheckbox(value: value, onChanged: onChanged);
  }
}
