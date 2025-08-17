// ignore_for_file: non_constant_identifier_names

import 'package:ui_kit/layout_padding.dart';
import 'package:ui_kit/layouts/desktop.dart';
import 'package:ui_kit/theme.dart';
import 'package:ui_kit/widgets.dart';
import 'package:ui_kit/widgets/app.dart';
import 'package:ui_kit/widgets/button.dart';
import 'package:ui_kit/widgets/checkbox.dart';
import 'package:ui_kit/widgets/dialog.dart';
import 'package:ui_kit/widgets/divider.dart';
import 'package:ui_kit/widgets/icon.dart';
import 'package:ui_kit/widgets/indicator.dart';
import 'package:ui_kit/widgets/list.dart';
import 'package:ui_kit/widgets/scaffold.dart';
import 'package:ui_kit/widgets/slider.dart';
import 'package:ui_kit/widgets/switcher.dart';
import 'package:ui_kit/widgets/text.dart';
import 'package:ui_kit_cupertino/theme_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/app_bar_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/app_bar_sliver_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/app_root_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/button_filled_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/button_icon_filled_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/checkbox_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/dialog_action_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/dialog_alert_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/divider_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/indicator_activity_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/list_chevron_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/list_section_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/list_tile_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/scaffold_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/show_dialog_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/slider_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/switcher_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/text_field_cupertino.dart';
import 'package:ui_kit_cupertino/widgets/uicon_cupertino.dart';

class WidgetsCupertino implements WidgetContainer {
  const WidgetsCupertino();

  @override
  AppRootFactory get AppRoot => AppRootCupertino.new;
  @override
  AppBarFactory get AppBar => AppBarCupertino.new;
  @override
  AppBarSliverFactory get AppBarSliver => AppBarSliverCupertino.new;
  @override
  AppDesktopFactory get AppDesktop => Desktop.new;

  @override
  ButtonFactory get Button => ButtonFilledCupertino.new;
  @override
  ButtonIconFactory get ButtonIcon => ButtonIconFilledCupertino.new;

  @override
  AlertDialogFactory get AlertDialog => AlertDialogCupertino.new;
  @override
  DialogActionFactory get DialogAction => DialogActionCupertino.new;
  @override
  ShowDialog get showDialog => showDialogCupertino;

  @override
  DividerFactory get Divider => DividerCupertino.new;

  @override
  IconFactory get Icon => UIconCupertino.new;

  @override
  IndicatorActivityFactory get IndicatorActivity =>
      IndicatorActivityCupertino.new;

  @override
  ListSectionFactory get ListSection => ListSectionCupertino.new;
  @override
  ListTileFactory get ListTile => ListTileCupertino.new;
  @override
  ListChevronFactory get ListChevron => ListChevronCupertino.new;

  @override
  ScaffoldFactory get Scaffold => ScaffoldCupertino.new;

  @override
  CheckboxFactory get Checkbox => CheckboxCupertino.new;
  @override
  SwitcherFactory get Switcher => SwitcherCupertino.new;
  @override
  SliderFactory get Slider => SliderCupertino.new;

  @override
  TextFieldFactory get TextField => TextFieldCupertino.new;

  @override
  LayoutPadding get DefaultPadding =>
      const LayoutPadding(start: 16, top: 22, end: 16, bottom: 8);

  @override
  ThemeBuilder get themeOf => ThemeCupertino.new;
}
