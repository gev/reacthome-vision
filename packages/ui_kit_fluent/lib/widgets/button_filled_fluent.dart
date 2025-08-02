import 'package:fluent_ui/fluent_ui.dart';

class ButtonFilledFluent extends StatelessWidget {
  final String label;
  final void Function()? onPressed;

  const ButtonFilledFluent({required this.label, this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return FilledButton(onPressed: onPressed, child: Text(label));
  }
}
