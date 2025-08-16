import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';

class AppBarMacos extends ToolBar {
  AppBarMacos({required String title, Widget? trailing, super.key})
    : super(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(title), ?trailing],
        ),
        titleWidth: double.infinity,
      );
}
