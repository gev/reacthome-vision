import 'package:fluent_ui/fluent_ui.dart';

class SliderFluent extends StatelessWidget {
  final double value;
  final double? min;
  final double? max;
  final void Function(double) onChanged;

  const SliderFluent({
    required this.value,
    this.min,
    this.max,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: value,
      min: min ?? 0,
      max: max ?? 1,
      onChanged: onChanged,
    );
  }
}
