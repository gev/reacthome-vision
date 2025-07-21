import 'package:flutter/material.dart';
import 'package:ui_kit/kit.dart';
import 'package:ui_kit/widgets/app.dart';
import 'package:ui_kit/widgets/button.dart';
import 'package:ui_kit/widgets/dialog.dart';
import 'package:ui_kit/widgets/icon.dart';
import 'package:ui_kit/widgets/indicator.dart';
import 'package:ui_kit/widgets/list.dart';
import 'package:ui_kit/widgets/text.dart';
import 'package:ui_kit_material/layout_material.dart';
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

void initMaterialKit() {
  Kit.init(
    app: AppContainer(
      root: AppRootMaterial.make,
      bar: (fixed: AppBarFixedMaterial.make, sliver: AppBarSliverMaterial.make),
    ),
    button: ButtonContainer(
      filled: ButtonFilledMaterial.make,
      icon: (filled: ButtonIconFilledMaterial.make),
    ),
    dialog: DialogContainer(
      show: showDialogMaterial,
      alert: AlertDialogMaterial.make,
      action: DialogActionMaterial.make,
    ),
    divider: DividerMaterial.make,
    icon: IconContainer(
      add: Icons.add,
      delete: Icons.delete,
      wifi: Icons.wifi,
      search: Icons.search,
      settings: Icons.settings,
      home: (filled: Icons.home, outlined: Icons.home_outlined),
    ),
    indicator: IndicatorContainer(activity: IndicatorActivityMaterial.make),
    list: ListContainer(
      section: ListSectionMaterial.make,
      tile: ListTileMaterial.make,
      chevron: ListChevronMaterial.make,
    ),
    scaffold: ScaffoldMaterial.make,
    switcher: SwitcherMaterial.make,
    text: TextContainer(field: TextFieldMaterial.make),
    layout: layout,
    theme: ThemeMaterial.new,
  );
}
