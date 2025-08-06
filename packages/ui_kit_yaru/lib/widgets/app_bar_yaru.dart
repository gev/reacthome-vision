import 'package:flutter/widgets.dart';
import 'package:yaru/yaru.dart';

class AppBarYaru extends YaruWindowTitleBar {
  AppBarYaru({required String title, Widget? trailing, super.key})
    : super(title: Text(title), actions: trailing != null ? [trailing] : []);
}
