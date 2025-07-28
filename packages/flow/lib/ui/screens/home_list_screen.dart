import 'package:flow/l10n/app_localizations.dart';
import 'package:flow/ui/view_models/home_list_view_model.dart';
import 'package:flow/ui/view_models/home_view_model.dart';
import 'package:flow/ui/views/home/home_go_to_add.dart';
import 'package:flow/ui/views/home/home_list.dart';
import 'package:flow/ui_kit/layouts/fixed_width_layout.dart';
import 'package:flutter/widgets.dart';

class HomeListScreen extends StatelessWidget {
  final HomesViewModel homeViewModel;
  final HomeListViewModel homeListViewModel;

  const HomeListScreen({
    required this.homeViewModel,
    required this.homeListViewModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return FixedWidthLayout(
      title: locale.myHomes,
      body: Column(
        children: [
          HomeList(homeViewModel, homeListViewModel),
          const HomeGoToAdd(),
        ],
      ),
    );
  }
}
