import 'package:flow/l10n/app_localizations.dart';
import 'package:flow/ui/view_models/discovery_view_model.dart';
import 'package:flow/ui_kit/kit.dart';
import 'package:flutter/widgets.dart';

class DiscoveryStatus extends StatelessWidget {
  final DiscoveryViewModel viewModel;

  const DiscoveryStatus(this.viewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return list.tile(
      title: Text(locale.discovery),
      leading: Icon(icon.search),
      trailing: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) => switcher(
          value: viewModel.state,
          onChanged: viewModel.toggleDiscovery,
        ),
      ),
    );
  }
}
