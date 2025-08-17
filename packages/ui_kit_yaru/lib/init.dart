import 'package:flutter/widgets.dart';
import 'package:ui_kit/widgets.dart';
import 'package:ui_kit_yaru/icons_yaru.dart';
import 'package:ui_kit_yaru/widgets_yaru.dart';
import 'package:yaru/yaru.dart';

Future<void> configureYaruWindow(Size size) async {
  WidgetsFlutterBinding.ensureInitialized();
  await YaruWindow.ensureInitialized();
  await YaruWindowTitleBar.ensureInitialized();
  // await windowManager.setMinimumSize(size);
  // await windowManager.setSize(size);
}

void initYaruKit() {
  UI = const WidgetsYaru();
  Icons = const IconsYaru();
}
