import 'package:ui_kit/layout.dart';
import 'package:ui_kit/theme_builder.dart';
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

class Kit {
  static late AppContainer app;
  static late ButtonContainer button;
  static late DialogContainer dialog;
  static late DividerFactory divider;
  static late IconContainer icon;
  static late IndicatorContainer indicator;
  static late ListContainer list;
  static late ScaffoldFactory scaffold;
  static late SwitcherFactory switcher;
  static late TextContainer text;
  static late LayoutContainer layout;
  static late ThemeBuilder theme;

  static void init({
    required AppContainer app,
    required ButtonContainer button,
    required DialogContainer dialog,
    required DividerFactory divider,
    required IconContainer icon,
    required IndicatorContainer indicator,
    required ListContainer list,
    required ScaffoldFactory scaffold,
    required SwitcherFactory switcher,
    required TextContainer text,
    required LayoutContainer layout,
    required ThemeBuilder theme,
  }) {
    Kit.app = app;
    Kit.button = button;
    Kit.dialog = dialog;
    Kit.divider = divider;
    Kit.icon = icon;
    Kit.indicator = indicator;
    Kit.list = list;
    Kit.scaffold = scaffold;
    Kit.switcher = switcher;
    Kit.text = text;
    Kit.layout = layout;
    Kit.theme = theme;
  }
}
