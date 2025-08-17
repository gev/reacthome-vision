import 'package:fluent_ui/fluent_ui.dart';

class CheckboxFluent extends StatelessWidget {
  final bool value;
  final Function(bool?)? onChanged;

  const CheckboxFluent({required this.value, this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return Checkbox(checked: value, onChanged: onChanged);
  }
}
