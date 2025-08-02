import 'package:flutter/cupertino.dart';
import 'package:ui_kit/icons.dart';
import 'package:ui_kit/layout_padding.dart';
import 'package:ui_kit/layout_paddings.dart';
import 'package:ui_kit/theme.dart';
import 'package:ui_kit/widgets.dart';
import 'package:ui_kit/widgets/icon.dart';
import 'package:ui_kit_cupertino/theme_cupertino.dart';
import 'package:ui_kit_cupertino/widgets_cupertino.dart';

void initCupertinoKit() {
  UI = const WidgetsCupertino();

  Icons = const IconContainer(
    add: CupertinoIcons.add,
    delete: CupertinoIcons.delete,
    search: CupertinoIcons.search,
    settings: CupertinoIcons.settings,
    wifi: CupertinoIcons.wifi,
    home: (filled: CupertinoIcons.house_fill, outlined: CupertinoIcons.house),
  );

  DefaultPadding = const LayoutPadding(start: 16, top: 22, end: 16, bottom: 8);

  themeOf = ThemeCupertino.new;
}
