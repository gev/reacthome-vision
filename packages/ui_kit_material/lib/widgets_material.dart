// ignore_for_file: non_constant_identifier_names

import 'package:flutter/widgets.dart';
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
import 'package:ui_kit_material/theme_material.dart';
import 'package:ui_kit_material/widgets/app_bar_material.dart';
import 'package:ui_kit_material/widgets/app_bar_sliver_material.dart';
import 'package:ui_kit_material/widgets/app_desktop_cupertino.dart';
import 'package:ui_kit_material/widgets/app_root_material.dart';
import 'package:ui_kit_material/widgets/button_filled_material.dart';
import 'package:ui_kit_material/widgets/button_icon_filled_material.dart';
import 'package:ui_kit_material/widgets/dialog_action_material.dart';
import 'package:ui_kit_material/widgets/dialog_alert_material.dart';
import 'package:ui_kit_material/widgets/divider_material.dart';
import 'package:ui_kit_material/widgets/icon_material.dart';
import 'package:ui_kit_material/widgets/indicator_activity_material.dart';
import 'package:ui_kit_material/widgets/list_chevron_material.dart';
import 'package:ui_kit_material/widgets/list_section_material.dart';
import 'package:ui_kit_material/widgets/list_tile_material.dart';
import 'package:ui_kit_material/widgets/scaffold_material.dart';
import 'package:ui_kit_material/widgets/show_dialog_material.dart';
import 'package:ui_kit_material/widgets/switcher_material.dart';
import 'package:ui_kit_material/widgets/text_field_material.dart';

class WidgetsMaterial implements WidgetContainer<PreferredSizeWidget> {
  const WidgetsMaterial();

  @override
  AppRootFactory get AppRoot => AppRootMaterial.new;
  @override
  AppBarFactory<PreferredSizeWidget> get AppBar => AppBarMaterial.new;
  @override
  AppBarSliverFactory get AppBarSliver => AppBarSliverMaterial.new;
  @override
  AppDesktopFactory get AppDesktop => AppDesktopMaterial.new;

  @override
  ButtonFactory get Button => ButtonFilledMaterial.new;
  @override
  ButtonIconFactory get ButtonIcon => ButtonIconFilledMaterial.new;

  @override
  AlertDialogFactory get AlertDialog => AlertDialogMaterial.new;
  @override
  DialogActionFactory get DialogAction => DialogActionMaterial.new;
  @override
  ShowDialog get showDialog => showDialogMaterial;

  @override
  DividerFactory get Divider => DividerMaterial.new;

  @override
  IconFactory get Icon => IconMaterial.new;

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
  ScaffoldFactory<PreferredSizeWidget> get Scaffold => ScaffoldMaterial.new;

  @override
  SwitcherFactory get Switcher => SwitcherMaterial.new;

  @override
  TextFieldFactory get TextField => TextFieldMaterial.new;

  @override
  LayoutPadding get DefaultPadding =>
      const LayoutPadding(start: 20, top: 25, end: 20, bottom: 10);

  @override
  ThemeBuilder get themeOf => ThemeMaterial.new;
}
