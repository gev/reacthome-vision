import 'package:flutter/cupertino.dart';
import 'package:ui_kit/icons.dart';
import 'package:ui_kit/layout_padding.dart';
import 'package:ui_kit/layout_paddings.dart';
import 'package:ui_kit/theme.dart';
import 'package:ui_kit/widgets.dart';
import 'package:ui_kit/widgets/icon.dart';
import 'package:ui_kit_cupertino/theme_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/app_bar_fixed_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/app_bar_sliver_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/app_root_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/button_filled_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/button_icon_filled_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/dialog_action_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/dialog_alert_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/divider_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/list_chevron_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/list_section_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/list_tile_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/scaffold_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/show_dialog_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/switcher_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/text_field_cupertino.dart';

void initCupertinoKit() {
  AppRoot = AppRootCupertino.new;
  AppBar = AppBarFixedCupertino.new;
  AppBarSliver = AppBarSliverCupertino.new;

  Button = ButtonFilledCupertino.new;
  ButtonIcon = ButtonIconFilledCupertino.new;

  AlertDialog = AlertDialogCupertino.new;
  DialogAction = DialogActionCupertino.new;
  showDialog = showDialogCupertino;

  Divider = DividerCupertino.new;

  ListSection = ListSectionCupertino.new;
  ListTile = ListTileCupertino.new;
  ListChevron = ListChevronCupertino.new;

  Scaffold = ScaffoldCupertino.new;
  Switcher = SwitcherCupertino.new;

  TextField = TextFieldCupertino.new;

  Icons = IconContainer(
    add: CupertinoIcons.add,
    delete: CupertinoIcons.delete,
    search: CupertinoIcons.search,
    settings: CupertinoIcons.settings,
    wifi: CupertinoIcons.wifi,
    home: (filled: CupertinoIcons.house_fill, outlined: CupertinoIcons.house),
  );

  DefaultPadding = LayoutPadding(start: 16, top: 22, end: 16, bottom: 8);

  themeOf = ThemeCupertino.new;
}
