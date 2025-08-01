import 'package:flutter/material.dart' as m;
import 'package:ui_kit/icons.dart';
import 'package:ui_kit/layout_padding.dart';
import 'package:ui_kit/layout_paddings.dart';
import 'package:ui_kit/theme.dart';
import 'package:ui_kit/widgets.dart';
import 'package:ui_kit/widgets/icon.dart';
import 'package:ui_kit_material/theme_material.dart';
import 'package:ui_kit_material/widgets/app_bar_fixed_material.dart';
import 'package:ui_kit_material/widgets/app_bar_sliver_material.dart';
import 'package:ui_kit_material/widgets/app_root_material.dart';
import 'package:ui_kit_material/widgets/button_filled_material.dart';
import 'package:ui_kit_material/widgets/button_icon_filled_material.dart';
import 'package:ui_kit_material/widgets/dialog_action_material.dart';
import 'package:ui_kit_material/widgets/dialog_alert_material.dart';
import 'package:ui_kit_material/widgets/divider_material.dart';
import 'package:ui_kit_material/widgets/indicator_activity_material.dart';
import 'package:ui_kit_material/widgets/list_chevron_material.dart';
import 'package:ui_kit_material/widgets/list_section_material.dart';
import 'package:ui_kit_material/widgets/list_tile_material.dart';
import 'package:ui_kit_material/widgets/scaffold_material.dart';
import 'package:ui_kit_material/widgets/show_dialog_material.dart';
import 'package:ui_kit_material/widgets/switcher_material.dart';
import 'package:ui_kit_material/widgets/text_field_material.dart';
import 'package:ui_kit_material/widgets/uicon_material.dart';

void initMaterialKit() {
  AppRoot = AppRootMaterial.new;
  AppBar = AppBarFixedMaterial.new;
  AppBarSliver = AppBarSliverMaterial.new;

  Button = ButtonFilledMaterial.new;
  ButtonIcon = ButtonIconFilledMaterial.new;

  AlertDialog = AlertDialogMaterial.new;
  DialogAction = DialogActionMaterial.new;
  showDialog = showDialogMaterial;

  Divider = DividerMaterial.new;

  IndicatorActivity = IndicatorActivityMaterial.new;

  ListSection = ListSectionMaterial.new;
  ListTile = ListTileMaterial.new;
  ListChevron = ListChevronMaterial.new;

  Scaffold = ScaffoldMaterial.new;
  Switcher = SwitcherMaterial.new;

  TextField = TextFieldMaterial.new;

  UIcon = UIconMaterial.new;

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
