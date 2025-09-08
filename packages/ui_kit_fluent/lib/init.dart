import 'package:flutter/widgets.dart';
import 'package:flutter_acrylic/window.dart';
import 'package:flutter_acrylic/window_effect.dart';
import 'package:ui_kit/widgets.dart';
import 'package:ui_kit_fluent/icons_fluent.dart';
import 'package:ui_kit_fluent/widgets_fluent.dart';
import 'package:window_manager/window_manager.dart';

Future<void> configureFluentWindow(Size size) async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  windowManager.waitUntilReadyToShow(
    const WindowOptions(titleBarStyle: TitleBarStyle.hidden),
    () async {
      await Window.initialize();
      await Window.setEffect(
        effect: WindowEffect.acrylic,
        // color: const Color(0xCC222222),
      );
      await windowManager.setMinimumSize(size);
    },
  );
}

void initFluentKit() {
  UI = const WidgetsFluent();
  Icons = const IconsFluent();
}
