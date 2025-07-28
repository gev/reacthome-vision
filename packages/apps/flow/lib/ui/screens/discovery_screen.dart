import 'package:flow/l10n/app_localizations.dart';
import 'package:flow/ui/view_models/discovery_view_model.dart';
import 'package:flow/ui/view_models/home_list_view_model.dart';
import 'package:flow/ui/view_models/home_view_model.dart';
import 'package:flow/ui/views/discovery/discovery_home_add.dart';
import 'package:flow/ui/views/discovery/discovery_home_list.dart';
import 'package:flow/ui/views/discovery/discovery_status.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_kit/layouts/fixed_width_layout.dart';
import 'package:ui_kit/widgets.dart';

class DiscoveryScreen extends StatelessWidget {
  final DiscoveryViewModel discoveryViewModel;
  final HomeListViewModel homeListViewModel;
  final HomesViewModel homeViewModel;

  const DiscoveryScreen({
    required this.discoveryViewModel,
    required this.homeListViewModel,
    required this.homeViewModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return FixedWidthLayout(
      title: locale.addAHome,
      body: Column(
        children: [
          ListSection(
            children: [
              DiscoveryHomeAdd(homeViewModel),
              DiscoveryStatus(discoveryViewModel),
            ],
          ),
          DiscoveryHomeList(
            discoveryViewModel,
            homeListViewModel,
            homeViewModel,
          ),
        ],
      ),
    );
  }
}
