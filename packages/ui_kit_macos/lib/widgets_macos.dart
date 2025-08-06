// ignore_for_file: non_constant_identifier_names

import 'package:macos_ui/macos_ui.dart';
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
import 'package:ui_kit_cupertino/theme_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/app_bar_sliver_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/divider_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/list_chevron_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/list_section_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/list_tile_cupertino.dart';
import 'package:ui_kit_macos/widgets/app_bar_macos.dart';
import 'package:ui_kit_macos/widgets/app_root_macos.dart';
import 'package:ui_kit_macos/widgets/button_filled_macos.dart';
import 'package:ui_kit_macos/widgets/button_icon_filled_macos.dart';
import 'package:ui_kit_macos/widgets/dialog_action_macos.dart';
import 'package:ui_kit_macos/widgets/dialog_alert_macos.dart';
import 'package:ui_kit_macos/widgets/icon_macos.dart';
import 'package:ui_kit_macos/widgets/indicator_activity_macos.dart';
import 'package:ui_kit_macos/widgets/scaffold_macos.dart';
import 'package:ui_kit_macos/widgets/show_dialog_macos.dart';
import 'package:ui_kit_macos/widgets/switcher_macos.dart';
import 'package:ui_kit_macos/widgets/text_field_macos.dart';

class WidgetsMacOS implements WidgetContainer<ToolBar> {
  const WidgetsMacOS();

  @override
  AppRootFactory get AppRoot => AppRootMacOS.new;
  @override
  AppBarFactory<ToolBar> get AppBar => AppBarMacos.new;
  @override
  AppBarSliverFactory get AppBarSliver => AppBarSliverCupertino.new;

  @override
  ButtonFactory get Button => ButtonFilledMacOS.new;
  @override
  ButtonIconFactory get ButtonIcon => ButtonIconFilledMacOS.new;

  @override
  AlertDialogFactory get AlertDialog => AlertDialogMacOS.new;
  @override
  DialogActionFactory get DialogAction => DialogActionMacOS.new;
  @override
  ShowDialog get showDialog => showDialogMacOS;

  @override
  DividerFactory get Divider => DividerCupertino.new;

  @override
  IconFactory get Icon => IconMacOS.new;

  @override
  IndicatorActivityFactory get IndicatorActivity => IndicatorActivityMacOS.new;

  @override
  ListSectionFactory get ListSection => ListSectionCupertino.new;
  @override
  ListTileFactory get ListTile => ListTileCupertino.new;
  @override
  ListChevronFactory get ListChevron => ListChevronCupertino.new;

  @override
  ScaffoldFactory<ToolBar> get Scaffold => ScaffoldMacOS.new;
  @override
  SwitcherFactory get Switcher => SwitcherMacOS.new;

  @override
  TextFieldFactory get TextField => TextFieldMacOS.new;

  @override
  LayoutPadding get DefaultPadding =>
      const LayoutPadding(start: 16, top: 22, end: 16, bottom: 8);

  @override
  ThemeBuilder get themeOf => ThemeCupertino.new;
}
