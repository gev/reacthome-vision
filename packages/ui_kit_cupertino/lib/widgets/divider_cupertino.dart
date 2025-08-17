import 'package:flutter/widgets.dart';
import 'package:ui_kit/widgets.dart';

class DividerCupertino extends StatelessWidget {
  const DividerCupertino({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = UI.themeOf(context);
    return Container(height: 1, color: theme.color.withAlpha(32));
  }
}
