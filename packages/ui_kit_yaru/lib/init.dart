import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_kit/widgets.dart';
import 'package:ui_kit_yaru/icons_yaru.dart';
import 'package:ui_kit_yaru/widgets_yaru.dart';
import 'package:yaru/yaru.dart';

Future<void> configureYaruWindow() async {
  await YaruWindowTitleBar.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  SemanticsBinding.instance.ensureSemantics();
}

void initYaruKit() {
  UI = const WidgetsYaru();
  Icons = const IconsYaru();
}
