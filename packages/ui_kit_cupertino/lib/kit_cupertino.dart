import 'package:flutter/cupertino.dart';
import 'package:ui_kit/kit.dart';
import 'package:ui_kit/widgets/app.dart';
import 'package:ui_kit/widgets/button.dart';
import 'package:ui_kit/widgets/dialog.dart';
import 'package:ui_kit/widgets/icon.dart';
import 'package:ui_kit/widgets/indicator.dart';
import 'package:ui_kit/widgets/list.dart';
import 'package:ui_kit/widgets/text.dart';
import 'package:ui_kit_cupertino/layout_cupertino.dart';
import 'package:ui_kit_cupertino/theme_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/app_bar_fixed_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/app_bar_sliver_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/app_root_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/button_filled_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/button_icon_filled_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/dialog_action_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/dialog_alert_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/divider_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/indicator_activity_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/list_chevron_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/list_section_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/list_tile_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/scaffold_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/show_dialog_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/switcher_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/text_field_cupertino.dart';

void initCupertinoKit() {
  Kit.init(
    app: AppContainer(
      root: AppRootCupertino.make,
      bar: (
        fixed: AppBarFixedCupertino.make,
        sliver: AppBarSliverCupertino.make,
      ),
    ),
    button: ButtonContainer(
      filled: ButtonFilledCupertino.make,
      icon: (filled: ButtonIconFilledCupertino.make),
    ),
    dialog: DialogContainer(
      show: showDialogCupertino,
      alert: AlertDialogCupertino.make,
      action: DialogActionCupertino.make,
    ),
    divider: DividerCupertino.make,
    icon: IconContainer(
      add: CupertinoIcons.add,
      delete: CupertinoIcons.delete,
      search: CupertinoIcons.search,
      settings: CupertinoIcons.settings,
      wifi: CupertinoIcons.wifi,
      home: (filled: CupertinoIcons.house_fill, outlined: CupertinoIcons.house),
    ),
    indicator: IndicatorContainer(activity: IndicatorActivityCupertino.make),
    list: ListContainer(
      section: ListSectionCupertino.make,
      tile: ListTileCupertino.make,
      chevron: ListChevronCupertino.make,
    ),
    scaffold: ScaffoldCupertino.make,
    switcher: SwitcherCupertino.make,
    text: TextContainer(field: TextFieldCupertino.make),
    layout: layout,
    theme: ThemeCupertino.new,
  );
}
