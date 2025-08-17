import 'package:flutter/cupertino.dart';

class CheckboxCupertino extends StatelessWidget {
  final bool value;
  final Function(bool?)? onChanged;

  const CheckboxCupertino({required this.value, this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoCheckbox(value: value, onChanged: onChanged);
  }
}
