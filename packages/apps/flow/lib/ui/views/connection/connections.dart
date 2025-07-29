import 'package:common/view_model_builder.dart';
import 'package:flow/ui/view_models/connection_view_model.dart';
import 'package:flow/ui/views/connection/connection.dart';
import 'package:flutter/widgets.dart';
import 'package:l10n/app_localizations.dart';
import 'package:ui_kit/widgets.dart';

class Connections extends StatelessWidget {
  final String id;
  final String? localAddress;
  final ConnectionsViewModel viewModel;

  const Connections(this.id, this.localAddress, this.viewModel, {super.key});

  @override
  Widget build(BuildContext context) => ViewModelBuilder(
    create: () => viewModel.makeConnectionViewModel(id),
    builder: (context, viewModel, _) {
      final locale = AppLocalizations.of(context)!;
      return ListSection(
        children: [
          Connection(
            isConnected: viewModel.isConnected,
            title: locale.connection,
            onToggle: viewModel.toggleConnection,
          ),
          Connection(
            isConnected: viewModel.isLocalConnected,
            title: locale.localConnection,
            subtitle: localAddress,
            onToggle: viewModel.toggleLocalConnection,
          ),
          Connection(
            isConnected: viewModel.isCloudConnected,
            title: locale.cloudConnection,
            subtitle: 'gate.reacthome.net',
            onToggle: viewModel.toggleCloudConnection,
          ),
        ],
      );
    },
  );
}
