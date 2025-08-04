import 'package:fluent_ui/fluent_ui.dart';

class SwitcherFluent extends StatelessWidget {
  final bool value;
  final Function(bool)? onChanged;

  const SwitcherFluent({required this.value, this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return ToggleSwitch(checked: value, onChanged: onChanged);
  }
}
