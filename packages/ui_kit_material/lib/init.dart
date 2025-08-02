import 'package:flutter/material.dart' as m;
import 'package:ui_kit/icons.dart';
import 'package:ui_kit/layout_padding.dart';
import 'package:ui_kit/layout_paddings.dart';
import 'package:ui_kit/theme.dart';
import 'package:ui_kit/widgets.dart';
import 'package:ui_kit/widgets/icon.dart';
import 'package:ui_kit_material/theme_material.dart';
import 'package:ui_kit_material/widgets_material.dart';

void initMaterialKit() {
  UI = const WidgetsMaterial();

  Icons = const IconContainer(
    add: m.Icons.add,
    delete: m.Icons.delete,
    wifi: m.Icons.wifi,
    search: m.Icons.search,
    settings: m.Icons.settings,
    home: (filled: m.Icons.home, outlined: m.Icons.home_outlined),
  );

  DefaultPadding = const LayoutPadding(start: 20, top: 25, end: 20, bottom: 10);

  themeOf = ThemeMaterial.new;
}
