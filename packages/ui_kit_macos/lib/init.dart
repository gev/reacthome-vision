import 'package:flutter/widgets.dart';
import 'package:flutter_acrylic/window.dart';
import 'package:flutter_acrylic/window_effect.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:ui_kit/widgets.dart';
import 'package:ui_kit_cupertino/icons_cupertino.dart';
import 'package:ui_kit_macos/widgets_macos.dart';
import 'package:window_manager/window_manager.dart';

Future<void> configureMacosWindow(Size size) async {
  WidgetsFlutterBinding.ensureInitialized();
  const config = MacosWindowUtilsConfig();
  await config.apply();
  await Window.setEffect(
    effect: WindowEffect.acrylic,
    color: const Color(0xCC222222),
  );
  await windowManager.ensureInitialized();
  await windowManager.setMinimumSize(size);
  await windowManager.setSize(size);
}

void initMacOSKit() {
  UI = const WidgetsMacos();
  Icons = const IconsCupertino();
}
