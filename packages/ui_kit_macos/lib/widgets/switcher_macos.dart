import 'package:flutter/cupertino.dart';

class SwitcherMacOS extends StatelessWidget {
  final bool value;
  final Function(bool)? onChanged;

  const SwitcherMacOS({required this.value, this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(value: value, onChanged: onChanged);
  }
}
