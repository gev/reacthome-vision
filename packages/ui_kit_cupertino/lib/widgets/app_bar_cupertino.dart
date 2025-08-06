import 'package:flutter/cupertino.dart';

class AppBarCupertino extends CupertinoNavigationBar {
  AppBarCupertino({required String title, super.trailing, super.key})
    : super(middle: Text(title));
}
