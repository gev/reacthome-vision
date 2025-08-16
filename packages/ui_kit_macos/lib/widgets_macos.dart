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
import 'package:ui_kit/widgets/slider.dart';
import 'package:ui_kit/widgets/switcher.dart';
import 'package:ui_kit/widgets/text.dart';
import 'package:ui_kit_cupertino/widgets/app_bar_sliver_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/divider_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/list_chevron_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/list_section_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/list_tile_cupertino.dart';
import 'package:ui_kit_macos/theme_macos.dart';
import 'package:ui_kit_macos/widgets/app_bar_macos.dart';
import 'package:ui_kit_macos/widgets/app_desktop_macos.dart';
import 'package:ui_kit_macos/widgets/app_root_macos.dart';
import 'package:ui_kit_macos/widgets/button_filled_macos.dart';
import 'package:ui_kit_macos/widgets/button_icon_filled_macos.dart';
import 'package:ui_kit_macos/widgets/dialog_action_macos.dart';
import 'package:ui_kit_macos/widgets/dialog_alert_macos.dart';
import 'package:ui_kit_macos/widgets/icon_macos.dart';
import 'package:ui_kit_macos/widgets/indicator_activity_macos.dart';
import 'package:ui_kit_macos/widgets/scaffold_macos.dart';
import 'package:ui_kit_macos/widgets/show_dialog_macos.dart';
import 'package:ui_kit_macos/widgets/slider_macos.dart';
import 'package:ui_kit_macos/widgets/switcher_macos.dart';
import 'package:ui_kit_macos/widgets/text_field_macos.dart';

class WidgetsMacos implements WidgetContainer {
  const WidgetsMacos();

  @override
  AppRootFactory get AppRoot => AppRootMacos.new;
  @override
  AppBarFactory get AppBar => AppBarMacos.new;
  @override
  AppBarSliverFactory get AppBarSliver => AppBarSliverCupertino.new;
  @override
  AppDesktopFactory get AppDesktop => AppDesktopMacos.new;

  @override
  ButtonFactory get Button => ButtonFilledMacos.new;
  @override
  ButtonIconFactory get ButtonIcon => ButtonIconFilledMacos.new;

  @override
  AlertDialogFactory get AlertDialog => AlertDialogMacos.new;
  @override
  DialogActionFactory get DialogAction => DialogActionMacos.new;
  @override
  ShowDialog get showDialog => showDialogMacos;

  @override
  DividerFactory get Divider => DividerCupertino.new;

  @override
  IconFactory get Icon => IconMacos.new;

  @override
  IndicatorActivityFactory get IndicatorActivity => IndicatorActivityMacos.new;

  @override
  ListSectionFactory get ListSection => ListSectionCupertino.new;
  @override
  ListTileFactory get ListTile => ListTileCupertino.new;
  @override
  ListChevronFactory get ListChevron => ListChevronCupertino.new;

  @override
  ScaffoldFactory get Scaffold => ScaffoldMacos.new;

  @override
  SliderFactory get Slider => SliderMacos.new;

  @override
  SwitcherFactory get Switcher => SwitcherMacos.new;

  @override
  TextFieldFactory get TextField => TextFieldMacos.new;

  @override
  LayoutPadding get DefaultPadding =>
      const LayoutPadding(start: 16, top: 22, end: 16, bottom: 8);

  @override
  ThemeBuilder get themeOf => ThemeMacos.new;
}
