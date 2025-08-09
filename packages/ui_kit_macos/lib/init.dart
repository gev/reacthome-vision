import 'package:flutter/widgets.dart';
import 'package:flutter_acrylic/window.dart';
import 'package:flutter_acrylic/window_effect.dart';
import 'package:ui_kit/widgets.dart';
import 'package:ui_kit_cupertino/icons_cupertino.dart';
import 'package:ui_kit_macos/widgets_macos.dart';

Future<void> configureMacosWindow() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Window.initialize();
  await Window.setEffect(
    effect: WindowEffect.acrylic,
    // color: const Color(0xCC222222),
  );
}

void initMacOSKit() {
  UI = const WidgetsMacos();
  Icons = const IconsCupertino();
}
