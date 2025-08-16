import 'package:flutter/widgets.dart';

typedef SliderFactory =
    Widget Function({
      required double value,
      double? min,
      double? max,
      required void Function(double) onChanged,
      Key? key,
    });
