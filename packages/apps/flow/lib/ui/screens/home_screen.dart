import 'package:common/view_model_builder.dart';
import 'package:flow/ui/view_models/connection_view_model.dart';
import 'package:flow/ui/view_models/home_view_model.dart';
import 'package:flow/ui/views/connection/connections.dart';
import 'package:flow/ui/views/home/home_go_to_list.dart';
import 'package:flow/ui/views/home/home_remove.dart';
import 'package:flow/ui/views/meta_props.dart';
import 'package:flutter/widgets.dart';
import 'package:l10n/app_localizations.dart';
import 'package:ui_kit/layouts/fixed_width_layout.dart';

class HomeScreen<E> extends StatelessWidget {
  final HomesViewModel homeViewModel;
  final ConnectionsViewModel connectionViewModel;

  const HomeScreen({
    required this.homeViewModel,
    required this.connectionViewModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final arguments =
        ModalRoute.of(context)!.settings.arguments as ({String id});
    return ViewModelBuilder(
      create: () => homeViewModel.makeViewModel(arguments.id, locale),
      builder: (context, viewModel, _) {
        final home = viewModel.home;
        return FixedWidthLayout(
          title: home.meta.name,
          body: Column(
            children: [
              MetaProps(arguments.id, home.meta),
              Connections(arguments.id, home.address, connectionViewModel),
              HomeRemove(arguments.id, viewModel),
              const HomeGoToList(),
            ],
          ),
        );
      },
    );
  }
}
