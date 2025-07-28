import 'package:flow/l10n/app_localizations.dart';
import 'package:flow/ui/navigation.dart';
import 'package:flow/ui_kit/kit.dart';
import 'package:flow/ui_kit/layouts/center_layout.dart';
import 'package:flow/ui_kit/theme.dart';
import 'package:flow/util/navigator_extension.dart';
import 'package:flutter/widgets.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return CenterLayout(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 240,
            child: Text(
              locale.welcome,
              textAlign: TextAlign.center,
              style: theme.largeTitle,
            ),
          ),
          SizedBox(height: layout.padding.vertical),
          button.filled(
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
