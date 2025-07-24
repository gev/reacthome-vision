import 'package:flutter/cupertino.dart';

class SwitcherCupertino extends StatelessWidget {
  final bool value;
  final Function(bool)? onChanged;

  const SwitcherCupertino({required this.value, this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(value: value, onChanged: onChanged);
  }
}
