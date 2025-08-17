import 'package:flutter/widgets.dart';

typedef CheckboxFactory =
    Widget Function({
      required bool value,
      void Function(bool?)? onChanged,
      Key? key,
    });
