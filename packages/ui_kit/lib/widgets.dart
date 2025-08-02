// ignore_for_file: non_constant_identifier_names

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

abstract interface class Widgets {
  AppRootFactory get AppRoot;
  AppBarFactory get AppBar;
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

  ScaffoldFactory get Scaffold;

  SwitcherFactory get Switcher;

  TextFieldFactory get TextField;
}

late final Widgets UI;
