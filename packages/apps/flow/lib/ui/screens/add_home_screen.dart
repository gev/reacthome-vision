import 'package:flow/l10n/app_localizations.dart';
import 'package:flow/ui/view_models/home_view_model.dart';
import 'package:flow/ui/views/home/home_add_form.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_kit/layouts/fixed_width_layout.dart';

class AddHomeScreen extends StatelessWidget {
  final HomesViewModel viewModel;

  const AddHomeScreen({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return FixedWidthLayout(
      title: locale.addTheHomeID,
      body: HomeAddForm(viewModel),
    );
  }
}
