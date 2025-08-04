// ignore_for_file: non_constant_identifier_names

import 'package:ui_kit/layout_padding.dart';
import 'package:ui_kit/theme.dart';
import 'package:ui_kit/widgets.dart';
import 'package:ui_kit/widgets/app.dart';
import 'package:ui_kit/widgets/button.dart';
import 'package:ui_kit/widgets/dialog.dart';
import 'package:ui_kit/widgets/divider.dart';
import 'package:ui_kit/widgets/icon.dart';
import 'package:ui_kit/widgets/indicator.dart';
import 'package:ui_kit/widgets/list.dart';
import 'package:ui_kit/widgets/scaffold.dart';
import 'package:ui_kit/widgets/switcher.dart';
import 'package:ui_kit/widgets/text.dart';
import 'package:ui_kit_material/widgets/app_bar_fixed_material.dart';
import 'package:ui_kit_material/widgets/app_bar_sliver_material.dart';
import 'package:ui_kit_material/widgets/button_filled_material.dart';
import 'package:ui_kit_material/widgets/button_icon_filled_material.dart';
import 'package:ui_kit_material/widgets/divider_material.dart';
import 'package:ui_kit_material/widgets/icon_material.dart';
import 'package:ui_kit_material/widgets/show_dialog_material.dart';
import 'package:ui_kit_material/widgets/text_field_material.dart';
import 'package:ui_kit_yaru/theme_yaru.dart';
import 'package:ui_kit_yaru/widgets/app_root_yaru.dart';
import 'package:ui_kit_yaru/widgets/dialog_action_yaru.dart';
import 'package:ui_kit_yaru/widgets/dialog_alert_yaru.dart';
import 'package:ui_kit_yaru/widgets/indicator_activity_yaru.dart';
import 'package:ui_kit_yaru/widgets/list_chevron_yaru.dart';
import 'package:ui_kit_yaru/widgets/list_section_yaru.dart';
import 'package:ui_kit_yaru/widgets/list_tile_yaru.dart';
import 'package:ui_kit_yaru/widgets/scaffold_yaru.dart';
import 'package:ui_kit_yaru/widgets/switcher_yaru.dart';

class WidgetsYaru implements WidgetContainer {
  const WidgetsYaru();

  @override
  AppRootFactory get AppRoot => AppRootYaru.new;
  @override
  AppBarFactory get AppBar => AppBarFixedMaterial.new;
  @override
  AppBarSliverFactory get AppBarSliver => AppBarSliverMaterial.new;

  @override
  ButtonFactory get Button => ButtonFilledMaterial.new;
  @override
  ButtonIconFactory get ButtonIcon => ButtonIconFilledMaterial.new;

  @override
  AlertDialogFactory get AlertDialog => AlertDialogYaru.new;
  @override
  DialogActionFactory get DialogAction => DialogActionYaru.new;
  @override
  ShowDialog get showDialog => showDialogMaterial;

  @override
  DividerFactory get Divider => DividerMaterial.new;

  @override
  IconFactory get Icon => IconMaterial.new;

  @override
  IndicatorActivityFactory get IndicatorActivity => IndicatorActivityYaru.new;

  @override
  ListSectionFactory get ListSection => ListSectionYaru.new;
  @override
  ListTileFactory get ListTile => ListTileYaru.new;
  @override
  ListChevronFactory get ListChevron => ListChevronYaru.new;

  @override
  ScaffoldFactory get Scaffold => ScaffoldYaru.new;

  @override
  SwitcherFactory get Switcher => SwitcherYaru.new;

  @override
  TextFieldFactory get TextField => TextFieldMaterial.new;

  @override
  LayoutPadding get DefaultPadding =>
      const LayoutPadding(start: 20, top: 25, end: 20, bottom: 10);

  @override
  ThemeBuilder get themeOf => ThemeYaru.new;
}
