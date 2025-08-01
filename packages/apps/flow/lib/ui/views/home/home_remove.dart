import 'package:flow/ui/navigation.dart';
import 'package:flow/ui/view_models/home_view_model.dart';
import 'package:flow/ui/views/home/home_remove_confirm.dart';
import 'package:flutter/widgets.dart';
import 'package:l10n/app_localizations.dart';
import 'package:navigation/navigator_extension.dart';
import 'package:ui_kit/icons.dart';
import 'package:ui_kit/widgets.dart';

class HomeRemove extends StatelessWidget {
  final String id;
  final HomeViewModel viewModel;

  const HomeRemove(this.id, this.viewModel, {super.key});

  void onHomeTileTap(String id, BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context,
      builder: (_) => HomeRemoveConfirm(id, viewModel),
    );
    if (confirmed == true) {
      viewModel.removeHome();
      if (context.mounted) {
        Navigator.of(context).clearNamed(NavigationRouteNames.myHomes);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return ListSection(
      children: [
        ListTile(
          title: Text(locale.removeThisHome),
          leading: UIcon(Icons.delete),
          onTap: () => onHomeTileTap(id, context),
        ),
      ],
    );
  }
}
