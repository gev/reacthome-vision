import 'package:macos_ui/macos_ui.dart';
import 'package:ui_kit/widgets.dart';
import 'package:ui_kit_cupertino/icons_cupertino.dart';
import 'package:ui_kit_macos/widgets_macos.dart';

Future<void> configureMacosWindowUtils() async {
  const config = MacosWindowUtilsConfig();
  await config.apply();
}

void initMacOSKit() {
  UI = const WidgetsMacOS();
  Icons = const IconsCupertino();
}
