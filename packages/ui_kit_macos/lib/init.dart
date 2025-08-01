import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:ui_kit/icons.dart';
import 'package:ui_kit/layout_padding.dart';
import 'package:ui_kit/layout_paddings.dart';
import 'package:ui_kit/theme.dart';
import 'package:ui_kit/widgets.dart';
import 'package:ui_kit/widgets/icon.dart';
import 'package:ui_kit_macos/theme_macos.dart';
import 'package:ui_kit_macos/widgets/app_bar_fixed_macos.dart';
import 'package:ui_kit_macos/widgets/app_bar_sliver_macos.dart';
import 'package:ui_kit_macos/widgets/app_root_macos.dart';
import 'package:ui_kit_macos/widgets/button_filled_macos.dart';
import 'package:ui_kit_macos/widgets/button_icon_filled_macos.dart';
import 'package:ui_kit_macos/widgets/dialog_action_macos.dart';
import 'package:ui_kit_macos/widgets/dialog_alert_macos.dart';
import 'package:ui_kit_macos/widgets/divider_macos.dart';
import 'package:ui_kit_macos/widgets/indicator_activity_macos.dart';
import 'package:ui_kit_macos/widgets/list_chevron_macos.dart';
import 'package:ui_kit_macos/widgets/list_section_macos.dart';
import 'package:ui_kit_macos/widgets/list_tile_macos.dart';
import 'package:ui_kit_macos/widgets/scaffold_macos.dart';
import 'package:ui_kit_macos/widgets/show_dialog_macos.dart';
import 'package:ui_kit_macos/widgets/switcher_macos.dart';
import 'package:ui_kit_macos/widgets/text_field_macos.dart';
import 'package:ui_kit_macos/widgets/uicon_macos.dart';

Future<void> configureMacosWindowUtils() async {
  const config = MacosWindowUtilsConfig();
  await config.apply();
}

void initMacOSKit() {
  AppRoot = AppRootMacOS.new;
  AppBar = AppBarFixedMacOS.new;
  AppBarSliver = AppBarSliverMacOS.new;

  Button = ButtonFilledMacOS.new;
  ButtonIcon = ButtonIconFilledMacOS.new;

  AlertDialog = AlertDialogMacOS.new;
  DialogAction = DialogActionMacOS.new;
  showDialog = showDialogMacOS;

  Divider = DividerMacOS.new;

  IndicatorActivity = IndicatorActivityMacOS.new;

  ListSection = ListSectionMacOS.new;
  ListTile = ListTileMacOS.new;
  ListChevron = ListChevronMacOS.new;

  Scaffold = ScaffoldMacOS.new;
  Switcher = SwitcherMacOS.new;

  TextField = TextFieldMacOS.new;

  UIcon = UIconMacOS.new;

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
