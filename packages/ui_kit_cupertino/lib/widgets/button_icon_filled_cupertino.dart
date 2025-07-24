import 'package:flutter/cupertino.dart';

class ButtonIconFilledCupertino extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function()? onPressed;

  const ButtonIconFilledCupertino({
    required this.label,
    required this.icon,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton.filled(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [Icon(icon, size: 28), const SizedBox(width: 8), Text(label)],
      ),
    );
  }
}
