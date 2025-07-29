import 'package:common/view_model_builder.dart';
import 'package:flow/ui/view_models/discovery_view_model.dart';
import 'package:flow/ui/view_models/home_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:l10n/app_localizations.dart';
import 'package:ui_kit/icons.dart';
import 'package:ui_kit/widgets.dart';

class DiscoveryHomeTile extends StatelessWidget {
  final String id;
  final DiscoveryViewModel discoveryViewModel;
  final HomesViewModel homeViewModel;
  final void Function() onTap;

  const DiscoveryHomeTile(
    this.id,
    this.discoveryViewModel,
    this.homeViewModel, {
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return ViewModelBuilder(
      create: () => homeViewModel.makeViewModel(id, locale),
      builder: (context, viewModel, _) {
        final home = viewModel.home;
        return ListTile(
          title: Text(home.meta.title),
          subtitle: Text(id, maxLines: 1, overflow: TextOverflow.ellipsis),
          leading: Icon(
            home.hasProject ? Icons.home.filled : Icons.home.outlined,
          ),
          onTap: onTap,
        );
      },
    );
  }
}
