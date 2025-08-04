import 'package:flutter/widgets.dart';
import 'package:ui_kit/icons.dart';
import 'package:yaru/yaru.dart';

class IconsYaru implements IconContainer {
  const IconsYaru();

  @override
  IconData get add => YaruIcons.plus;

  @override
  IconData get delete => YaruIcons.trash;

  @override
  IconData get search => YaruIcons.search;

  @override
  IconData get settings => YaruIcons.settings;

  @override
  IconData get wifi => YaruIcons.network_wireless;

  @override
  IconKind get home =>
      (filled: YaruIcons.home_filled, outlined: YaruIcons.home);
}
