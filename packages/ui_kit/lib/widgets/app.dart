import 'package:flutter/widgets.dart';
import 'package:navigation/navigation.dart';

typedef AppRootFactory =
    Widget Function({
      required String title,
      required Navigation navigation,
      required Color seedColor,
      Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates,
      Iterable<Locale>? supportedLocales,
    });

typedef AppBarFactory =
    Widget Function({required String title, Widget? trailing, Key? key});

typedef AppBarSliverFactory =
    Widget Function({required String title, Widget? trailing, Key? key});

typedef AppDesktopFactory =
    Widget Function({
      required Widget startSidebar,
      required Widget endSidebar,
      required Widget body,
      Widget? title,
    });
