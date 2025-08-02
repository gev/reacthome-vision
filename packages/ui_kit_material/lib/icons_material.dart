import 'package:flutter/material.dart' as m;
import 'package:flutter/widgets.dart';
import 'package:ui_kit/icons.dart';

class IconsMaterial implements IconContainer {
  const IconsMaterial();

  @override
  IconData get add => m.Icons.add;

  @override
  IconData get delete => m.Icons.delete;

  @override
  IconData get search => m.Icons.search;

  @override
  IconData get settings => m.Icons.settings;

  @override
  IconData get wifi => m.Icons.wifi;

  @override
  IconKind get home => (filled: m.Icons.home, outlined: m.Icons.home_outlined);
}
