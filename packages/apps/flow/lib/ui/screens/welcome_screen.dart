import 'package:flow/ui/navigation.dart';
import 'package:flutter/widgets.dart';
import 'package:l10n/app_localizations.dart';
import 'package:navigation/navigator_extension.dart';
import 'package:ui_kit/layouts/center_layout.dart';
import 'package:ui_kit/widgets.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final theme = UI.themeOf(context);
    return CenterLayout(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 240,
            child: Text(
              locale.welcome,
              textAlign: TextAlign.center,
              style: theme.titleStyle,
            ),
          ),
          SizedBox(height: UI.DefaultPadding.vertical),
          UI.Button(
            label: locale.addAHome,
            onPressed: () => Navigator.of(
              context,
            ).clearNamed(NavigationRouteNames.discovery),
          ),
        ],
      ),
    );
  }
}
