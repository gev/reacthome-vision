import 'package:flutter/cupertino.dart';
import 'package:ui_kit/icons.dart';

class IconsCupertino implements IconContainer {
  const IconsCupertino();

  @override
  IconData get add => CupertinoIcons.add;
  @override
  IconData get delete => CupertinoIcons.delete;
  @override
  IconData get search => CupertinoIcons.search;
  @override
  IconData get settings => CupertinoIcons.settings;
  @override
  IconData get wifi => CupertinoIcons.wifi;
  @override
  IconKind get home =>
      (filled: CupertinoIcons.house_fill, outlined: CupertinoIcons.house);
}
