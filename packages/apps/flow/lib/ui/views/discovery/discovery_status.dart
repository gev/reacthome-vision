import 'package:flow/ui/view_models/discovery_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:l10n/app_localizations.dart';
import 'package:ui_kit/icons.dart';
import 'package:ui_kit/widgets.dart';

class DiscoveryStatus extends StatelessWidget {
  final DiscoveryViewModel viewModel;

  const DiscoveryStatus(this.viewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return ListTile(
      title: Text(locale.discovery),
      leading: UIcon(Icons.search),
      trailing: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) => Switcher(
          value: viewModel.state,
          onChanged: viewModel.toggleDiscovery,
        ),
      ),
    );
  }
}
