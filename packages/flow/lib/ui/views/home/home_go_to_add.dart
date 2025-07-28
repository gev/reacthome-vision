import 'package:flow/l10n/app_localizations.dart';
import 'package:flow/ui/navigation.dart';
import 'package:flow/ui_kit/kit.dart';
import 'package:flutter/widgets.dart';

class HomeGoToAdd extends StatelessWidget {
  const HomeGoToAdd({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return list.section(
      context,
      children: [
        list.tile(
          title: Text(locale.addAHome),
          leading: Icon(icon.add),
          trailing: list.chevron(),
          onTap: () =>
              Navigator.of(context).pushNamed(NavigationRouteNames.discovery),
        ),
      ],
    );
  }
}
