import 'package:flutter/widgets.dart';
import 'package:ui_kit/navigation.dart';

typedef AppRootFactory =
    Widget Function({
      required String title,
      required Navigation navigation,
      required Color seedColor,
    });

typedef AppBarFactory =
    PreferredSizeWidget Function({required String title, Widget? trailing});

typedef AppBarSliverFactory =
    Widget Function({required String title, Widget? trailing});
