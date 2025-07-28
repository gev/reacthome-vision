import 'package:flow/l10n/app_localizations.dart';
import 'package:flow/ui/navigation.dart';
import 'package:flow/ui/view_models/discovery_view_model.dart';
import 'package:flow/ui/view_models/home_list_view_model.dart';
import 'package:flow/ui/view_models/home_view_model.dart';
import 'package:flow/ui/views/discovery/discovery_home_add_alert.dart';
import 'package:flow/ui/views/discovery/discovery_home_add_confirm.dart';
import 'package:flow/ui/views/discovery/discovery_home_tile.dart';
import 'package:flutter/widgets.dart';
import 'package:navigation/navigator_extension.dart';
import 'package:ui_kit/widgets.dart';

class DiscoveryHomeList extends StatelessWidget {
  final DiscoveryViewModel discoveryViewModel;
  final HomeListViewModel homeListViewModel;
  final HomesViewModel homeViewModel;

  const DiscoveryHomeList(
    this.discoveryViewModel,
    this.homeListViewModel,
    this.homeViewModel, {
    super.key,
  });

  void onHomeTileTap(
    String id,
    BuildContext context,
    AppLocalizations locale,
  ) async {
    final confirmed = await showDialog<bool>(
      context,
      builder: (_) => DiscoveryHomeAddConfirm(id, homeViewModel),
    );
    if (confirmed == true) {
      if (discoveryViewModel.tryAddHome(id)) {
        if (context.mounted) {
          Navigator.of(
            context,
          ).clearNamed(NavigationRouteNames.home, arguments: (id: id));
        }
      } else {
        if (context.mounted) {
          showDialog(context, builder: (_) => const DiscoveryHomeAddAlert());
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return ListenableBuilder(
      listenable: homeListViewModel,
      builder: (context, _) {
        final homes = homeListViewModel.homes;
        return homes.isEmpty
            ? const SizedBox()
            : ListSection(
                title: locale.discovered,
                children: homes
                    .map(
                      (id) => DiscoveryHomeTile(
                        id,
                        key: ValueKey(id),
                        discoveryViewModel,
                        homeViewModel,
                        onTap: () => onHomeTileTap(id, context, locale),
                      ),
                    )
                    .toList(),
              );
      },
    );
  }
}
