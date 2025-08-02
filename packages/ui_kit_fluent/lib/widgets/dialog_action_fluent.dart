import 'package:fluent_ui/fluent_ui.dart';

class DialogActionFluent extends StatelessWidget {
  final String label;
  final bool isDefaultAction;
  final bool isDestructiveAction;
  final void Function()? onPressed;

  const DialogActionFluent({
    required this.label,
    this.isDefaultAction = false,
    this.isDestructiveAction = false,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return isDestructiveAction
        ? FilledButton(onPressed: onPressed, child: Text(label))
        : Button(onPressed: onPressed, child: Text(label));
  }
}
