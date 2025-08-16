import 'package:flutter/widgets.dart';
import 'package:macos_ui/macos_ui.dart';

class SliderMacos extends StatelessWidget {
  final double value;
  final double? min;
  final double? max;
  final void Function(double) onChanged;

  const SliderMacos({
    required this.value,
    this.min,
    this.max,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MacosSlider(
      value: value,
      min: min ?? 0,
      max: max ?? 1,
      onChanged: onChanged,
    );
  }
}
