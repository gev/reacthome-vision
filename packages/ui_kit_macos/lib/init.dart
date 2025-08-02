import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:ui_kit/icons.dart';
import 'package:ui_kit/layout_padding.dart';
import 'package:ui_kit/layout_paddings.dart';
import 'package:ui_kit/theme.dart';
import 'package:ui_kit/widgets.dart';
import 'package:ui_kit/widgets/icon.dart';
import 'package:ui_kit_macos/theme_macos.dart';
import 'package:ui_kit_macos/widgets_macos.dart';

Future<void> configureMacosWindowUtils() async {
  const config = MacosWindowUtilsConfig();
  await config.apply();
}

void initMacOSKit() {
  UI = const WidgetsMacOS();

  Icons = const IconContainer(
    add: CupertinoIcons.add,
    delete: CupertinoIcons.delete,
    search: CupertinoIcons.search,
    settings: CupertinoIcons.settings,
    wifi: CupertinoIcons.wifi,
    home: (filled: CupertinoIcons.house_fill, outlined: CupertinoIcons.house),
  );

  DefaultPadding = const LayoutPadding(start: 16, top: 22, end: 16, bottom: 8);

  themeOf = ThemeMacOS.new;
}
