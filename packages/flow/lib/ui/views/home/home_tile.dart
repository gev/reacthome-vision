import 'package:flow/common/view_model_builder.dart';
import 'package:flow/l10n/app_localizations.dart';
import 'package:flow/ui/navigation.dart';
import 'package:flow/ui/view_models/home_view_model.dart';
import 'package:flow/util/navigator_extension.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_kit/icons.dart';
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
        return ListTile(
          title: Text(home.meta.name),
          subtitle: Text(id, maxLines: 1, overflow: TextOverflow.ellipsis),
          leading: Icon(
            home.hasProject ? Icons.home.filled : Icons.home.outlined,
          ),
          trailing: ListChevron(),
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
