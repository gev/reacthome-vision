import 'package:flutter/cupertino.dart';

class AppBarFixedMacOS extends CupertinoNavigationBar {
  AppBarFixedMacOS({required String title, super.trailing, super.key})
    : super(middle: Text(title));
}
