// ignore_for_file: non_constant_identifier_names

import 'package:flutter/widgets.dart';
import 'package:ui_kit/icons.dart';
import 'package:ui_kit/layout_padding.dart';
import 'package:ui_kit/theme.dart';
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

abstract interface class WidgetContainer<AB extends Widget> {
  AppRootFactory get AppRoot;
  AppBarFactory<AB> get AppBar;
  AppBarSliverFactory get AppBarSliver;

  ButtonFactory get Button;
  ButtonIconFactory get ButtonIcon;

  AlertDialogFactory get AlertDialog;
  DialogActionFactory get DialogAction;
  ShowDialog get showDialog;

  DividerFactory get Divider;

  IconFactory get Icon;
  IndicatorActivityFactory get IndicatorActivity;

  ListChevronFactory get ListChevron;
  ListTileFactory get ListTile;
  ListSectionFactory get ListSection;

  ScaffoldFactory<AB> get Scaffold;

  SwitcherFactory get Switcher;

  TextFieldFactory get TextField;

  LayoutPadding get DefaultPadding;

  ThemeBuilder get themeOf;
}

late final WidgetContainer UI;
late final IconContainer Icons;
