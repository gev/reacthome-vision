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
import 'package:ui_kit_fluent/widgets/app_root_fluent.dart';
import 'package:ui_kit_fluent/widgets/button_filled_fluent.dart';
import 'package:ui_kit_fluent/widgets/button_icon_filled_fluent.dart';
import 'package:ui_kit_fluent/widgets/dialog_action_fluent.dart';
import 'package:ui_kit_fluent/widgets/dialog_alert_fluent.dart';
import 'package:ui_kit_fluent/widgets/show_dialog_fluent.dart';
import 'package:ui_kit_material/theme_material.dart';
import 'package:ui_kit_material/widgets/app_bar_fixed_material.dart';
import 'package:ui_kit_material/widgets/app_bar_sliver_material.dart';
import 'package:ui_kit_material/widgets/divider_material.dart';
import 'package:ui_kit_material/widgets/icon_material.dart';
import 'package:ui_kit_material/widgets/indicator_activity_material.dart';
import 'package:ui_kit_material/widgets/list_chevron_material.dart';
import 'package:ui_kit_material/widgets/list_section_material.dart';
import 'package:ui_kit_material/widgets/list_tile_material.dart';
import 'package:ui_kit_material/widgets/scaffold_material.dart';
import 'package:ui_kit_material/widgets/switcher_material.dart';
import 'package:ui_kit_material/widgets/text_field_material.dart';

class WidgetsFluent implements WidgetContainer {
  const WidgetsFluent();

  @override
  AppRootFactory get AppRoot => AppRootFluent.new;
  @override
  AppBarFactory get AppBar => AppBarFixedMaterial.new;
  @override
  AppBarSliverFactory get AppBarSliver => AppBarSliverMaterial.new;

  @override
  ButtonFactory get Button => ButtonFilledFluent.new;
  @override
  ButtonIconFactory get ButtonIcon => ButtonIconFilledFluent.new;

  @override
  AlertDialogFactory get AlertDialog => AlertDialogFluent.new;
  @override
  DialogActionFactory get DialogAction => DialogActionFluent.new;
  @override
  ShowDialog get showDialog => showDialogFluent;

  @override
  DividerFactory get Divider => DividerMaterial.new;

  @override
  IndicatorActivityFactory get IndicatorActivity =>
      IndicatorActivityMaterial.new;

  @override
  ListSectionFactory get ListSection => ListSectionMaterial.new;
  @override
  ListTileFactory get ListTile => ListTileMaterial.new;
  @override
  ListChevronFactory get ListChevron => ListChevronMaterial.new;

  @override
  ScaffoldFactory get Scaffold => ScaffoldMaterial.new;

  @override
  SwitcherFactory get Switcher => SwitcherMaterial.new;

  @override
  TextFieldFactory get TextField => TextFieldMaterial.new;

  @override
  IconFactory get Icon => IconMaterial.new;

  @override
  LayoutPadding get DefaultPadding =>
      const LayoutPadding(start: 20, top: 25, end: 20, bottom: 10);

  @override
  ThemeBuilder get themeOf => ThemeMaterial.new;
}
