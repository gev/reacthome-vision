import 'package:flutter/widgets.dart';

typedef ListChevronFactory = Widget Function();

typedef ListTileFactory =
    Widget Function({
      required Widget title,
      Widget? subtitle,
      Widget? leading,
      Widget? trailing,
      void Function()? onTap,
      Key? key,
    });

typedef ListSectionFactory =
    Widget Function({
      String? title,
      required List<Widget> children,
      bool hasLeading,
      Key? key,
    });
