import 'package:flutter/material.dart';

class ButtonFilledMaterial extends StatelessWidget {
  final String label;
  final void Function()? onPressed;

  const ButtonFilledMaterial({required this.label, this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return FilledButton(onPressed: onPressed, child: Text(label));
  }
}
