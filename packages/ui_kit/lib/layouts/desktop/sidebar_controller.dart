import 'dart:math';

import 'package:flutter/widgets.dart';

class SidebarController extends ValueNotifier<double> {
  final double minSize;
  final double maxSize;

  double get size => value;

  SidebarController(
    super.size, {
    this.minSize = 0,
    this.maxSize = double.infinity,
  });

  void resizeBy(double delta) {
    value = max(minSize, min(maxSize, value + delta));
    notifyListeners();
  }
}
