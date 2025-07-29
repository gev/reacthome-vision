import 'package:flow/ui/navigation.dart';
import 'package:flutter/widgets.dart';
import 'package:l10n/app_localizations.dart';
import 'package:ui_kit/widgets.dart';

class HomeGoToList extends StatelessWidget {
  const HomeGoToList({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return ListSection(
      children: [
        ListTile(
          title: Text(locale.myHomes),
          trailing: ListChevron(),
          onTap: () =>
              Navigator.of(context).pushNamed(NavigationRouteNames.myHomes),
        ),
      ],
    );
  }
}
