import 'package:flutter/cupertino.dart';

class SliderCupertino extends StatelessWidget {
  final double value;
  final double? min;
  final double? max;
  final void Function(double) onChanged;

  const SliderCupertino({
    required this.value,
    this.min,
    this.max,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoSlider(
      value: value,
      min: min ?? 0,
      max: max ?? 1,
      onChanged: onChanged,
    );
  }
}
