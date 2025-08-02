import 'package:fluent_ui/fluent_ui.dart';

class ButtonIconFilledFluent extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function()? onPressed;

  const ButtonIconFilledFluent({
    required this.label,
    required this.icon,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [Icon(icon, size: 28), const SizedBox(width: 8), Text(label)],
      ),
    );
  }
}
