import 'package:flutter/widgets.dart';
import 'package:flutter_acrylic/window.dart';
import 'package:flutter_acrylic/window_effect.dart';
import 'package:ui_kit/widgets.dart';
import 'package:ui_kit_fluent/icons_fluent.dart';
import 'package:ui_kit_fluent/widgets_fluent.dart';
import 'package:window_manager/window_manager.dart';

Future<void> configureFluentWindow() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Window.initialize();
  await Window.hideWindowControls();
  await WindowManager.instance.ensureInitialized();
  await windowManager.waitUntilReadyToShow();
  await windowManager.setTitleBarStyle(
    TitleBarStyle.hidden,
    windowButtonVisibility: false,
  );
  await windowManager.show();
  await Window.setEffect(
    effect: WindowEffect.acrylic,
    // color: const Color(0xCC222222),
  );
}

void initFluentKit() {
  UI = const WidgetsFluent();
  Icons = const IconsFluent();
}
