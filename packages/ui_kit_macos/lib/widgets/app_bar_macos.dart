import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';

class AppBarMacos extends ToolBar {
  AppBarMacos({required String title, Widget? trailing, super.key})
    : super(
        title: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(title)],
        ),
        actions: trailing != null
            ? [
                CustomToolbarItem(
                  inToolbarBuilder: (context) => GestureDetector(
                    child: SizedBox(width: 200, child: trailing),
                  ),
                ),
              ]
            : [],
        // titleWidth: double.infinity,
      );
}
