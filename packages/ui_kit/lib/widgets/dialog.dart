import 'package:flutter/widgets.dart';

typedef DialogActionFactory =
    Widget Function({
      required String label,
      bool isDefaultAction,
      bool isDestructiveAction,
      void Function()? onPressed,
      Key? key,
    });

typedef AlertDialogFactory =
    Widget Function({
      Widget? title,
      Widget? content,
      required List<Widget> actions,
      Key? key,
    });

typedef ShowDialog =
    Future<T?> Function<T>(
      BuildContext context, {
      required WidgetBuilder builder,
    });
