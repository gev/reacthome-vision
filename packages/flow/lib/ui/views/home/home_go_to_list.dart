import 'package:flow/l10n/app_localizations.dart';
import 'package:flow/ui/navigation.dart';
import 'package:flow/ui_kit/kit.dart';
import 'package:flutter/widgets.dart';

class HomeGoToList extends StatelessWidget {
  const HomeGoToList({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return list.section(
      context,
      children: [
        list.tile(
          title: Text(locale.myHomes),
          trailing: list.chevron(),
          onTap: () =>
              Navigator.of(context).pushNamed(NavigationRouteNames.myHomes),
        ),
      ],
    );
  }
}
