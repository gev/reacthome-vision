import 'package:flutter/material.dart';

class ButtonIconFilledMaterial extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function()? onPressed;

  const ButtonIconFilledMaterial({
    required this.label,
    required this.icon,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
    );
  }
}
