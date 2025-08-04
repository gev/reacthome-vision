import 'package:flutter/material.dart';
import 'package:yaru/yaru.dart';

class SwitcherYaru extends StatelessWidget {
  final bool value;
  final Function(bool)? onChanged;

  const SwitcherYaru({required this.value, this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return YaruSwitch(value: value, onChanged: onChanged);
  }
}
