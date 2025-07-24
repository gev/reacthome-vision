import 'package:flutter/cupertino.dart';

class AppBarFixedCupertino extends CupertinoNavigationBar {
  AppBarFixedCupertino({required String title, super.trailing, super.key})
    : super(middle: Text(title));
}
