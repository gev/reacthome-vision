import 'package:flutter/widgets.dart';

typedef ButtonFactory =
    Widget Function({required String label, Function()? onPressed});

typedef ButtonIconFactory =
    Widget Function({
      required String label,
      required IconData icon,
      Function()? onPressed,
    });
