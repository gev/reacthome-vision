// ignore_for_file: non_constant_identifier_names

import 'package:ui_kit/layout_padding.dart';
import 'package:ui_kit/layouts/desktop.dart';
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
import 'package:ui_kit_fluent/theme_fluent.dart';
import 'package:ui_kit_fluent/widgets/app_root_fluent.dart';
import 'package:ui_kit_fluent/widgets/button_filled_fluent.dart';
import 'package:ui_kit_fluent/widgets/button_icon_filled_fluent.dart';
import 'package:ui_kit_fluent/widgets/dialog_action_fluent.dart';
import 'package:ui_kit_fluent/widgets/dialog_alert_fluent.dart';
import 'package:ui_kit_fluent/widgets/indicator_activity_fluent.dart';
import 'package:ui_kit_fluent/widgets/list_chevron_fluent.dart';
import 'package:ui_kit_fluent/widgets/list_section_fluent.dart';
import 'package:ui_kit_fluent/widgets/list_tile_fluent.dart';
import 'package:ui_kit_fluent/widgets/scaffold_fluent.dart';
import 'package:ui_kit_fluent/widgets/show_dialog_fluent.dart';
import 'package:ui_kit_fluent/widgets/switcher_fluent.dart';
import 'package:ui_kit_fluent/widgets/text_field_fluent.dart';
import 'package:ui_kit_material/widgets/app_bar_material.dart';
import 'package:ui_kit_material/widgets/app_bar_sliver_material.dart';
import 'package:ui_kit_material/widgets/divider_material.dart';
import 'package:ui_kit_material/widgets/icon_material.dart';

class WidgetsFluent implements WidgetContainer {
  const WidgetsFluent();

  @override
  AppRootFactory get AppRoot => AppRootFluent.new;
  @override
  AppBarFactory get AppBar => AppBarMaterial.new;
  @override
  AppBarSliverFactory get AppBarSliver => AppBarSliverMaterial.new;
  @override
  AppDesktopFactory get AppDesktop => Desktop.new;

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
  IconFactory get Icon => IconMaterial.new;

  @override
  IndicatorActivityFactory get IndicatorActivity => IndicatorActivityFluent.new;

  @override
  ListSectionFactory get ListSection => ListSectionFluent.new;
  @override
  ListTileFactory get ListTile => ListTileFluent.new;
  @override
  ListChevronFactory get ListChevron => ListChevronFluent.new;

  @override
  ScaffoldFactory get Scaffold => ScaffoldFluent.new;

  @override
  SwitcherFactory get Switcher => SwitcherFluent.new;

  @override
  TextFieldFactory get TextField => TextFieldFluent.new;

  @override
  LayoutPadding get DefaultPadding =>
      const LayoutPadding(start: 20, top: 25, end: 20, bottom: 10);

  @override
  ThemeBuilder get themeOf => ThemeFluent.new;
}
