import 'package:common/view_model_builder.dart';
import 'package:flow/ui/navigation.dart';
import 'package:flow/ui/view_models/home_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:l10n/app_localizations.dart';
import 'package:navigation/navigator_extension.dart';
import 'package:ui_kit/widgets.dart';

class HomeTile extends StatelessWidget {
  final String id;
  final HomesViewModel homeViewModel;

  const HomeTile(this.id, this.homeViewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return ViewModelBuilder(
      create: () => homeViewModel.makeViewModel(id, locale),
      builder: (context, viewModel, _) {
        final home = viewModel.home;
        return UI.ListTile(
          title: Text(home.meta.name),
          subtitle: Text(id, maxLines: 1, overflow: TextOverflow.ellipsis),
          leading: UI.Icon(
            home.hasProject ? Icons.home.filled : Icons.home.outlined,
          ),
          trailing: UI.ListChevron(),
          onTap: () {
            viewModel.setCurrentHome();
            Navigator.of(
              context,
            ).clearNamed(NavigationRouteNames.home, arguments: (id: id));
          },
        );
      },
    );
  }
}
