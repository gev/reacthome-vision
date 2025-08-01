import 'package:flow/ui/navigation.dart';
import 'package:flutter/widgets.dart';
import 'package:l10n/app_localizations.dart';
import 'package:ui_kit/icons.dart';
import 'package:ui_kit/widgets.dart';

class HomeGoToAdd extends StatelessWidget {
  const HomeGoToAdd({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return ListSection(
      children: [
        ListTile(
          title: Text(locale.addAHome),
          leading: UIcon(Icons.add),
          trailing: ListChevron(),
          onTap: () =>
              Navigator.of(context).pushNamed(NavigationRouteNames.discovery),
        ),
      ],
    );
  }
}
