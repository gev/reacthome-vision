import 'package:flow/l10n/app_localizations.dart';
import 'package:flow/ui/navigation.dart';
import 'package:flow/ui/view_models/home_view_model.dart';
import 'package:flow/ui_kit/kit.dart';
import 'package:flutter/widgets.dart';

class DiscoveryHomeAdd extends StatelessWidget {
  final HomesViewModel viewModel;

  const DiscoveryHomeAdd(this.viewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return list.tile(
      title: Text(locale.addTheHomeID),
      leading: Icon(icon.add),
      trailing: list.chevron(),
      onTap: () =>
          Navigator.of(context).pushNamed(NavigationRouteNames.addHome),
    );
  }
}
