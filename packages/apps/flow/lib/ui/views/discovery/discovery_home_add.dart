import 'package:flow/ui/navigation.dart';
import 'package:flow/ui/view_models/home_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:l10n/app_localizations.dart';
import 'package:ui_kit/widgets.dart';

class DiscoveryHomeAdd extends StatelessWidget {
  final HomesViewModel viewModel;

  const DiscoveryHomeAdd(this.viewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return UI.ListTile(
      title: Text(locale.addTheHomeID),
      leading: UI.Icon(Icons.add),
      trailing: UI.ListChevron(),
      onTap: () =>
          Navigator.of(context).pushNamed(NavigationRouteNames.addHome),
    );
  }
}
