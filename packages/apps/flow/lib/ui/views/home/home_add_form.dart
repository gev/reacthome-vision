import 'package:flow/ui/navigation.dart';
import 'package:flow/ui/view_models/home_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:l10n/app_localizations.dart';
import 'package:navigation/navigator_extension.dart';
import 'package:ui_kit/widgets.dart';

class HomeAddForm extends StatefulWidget {
  final HomesViewModel viewModel;

  const HomeAddForm(this.viewModel, {super.key});

  @override
  State<StatefulWidget> createState() => _HomeAddFormState();
}

class _HomeAddFormState extends State<HomeAddForm> {
  late TextEditingController _id;

  @override
  void initState() {
    super.initState();
    _id = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return Column(
      children: [
        UI.DefaultPadding.all(
          child: UI.TextField(
            controller: _id,
            placeholder: 'XXXX-XXXX-XXXX-XXXX-XXXX',
          ),
        ),
        UI.DefaultPadding.all(
          child: UI.Button(
            label: locale.add,
            onPressed: () {
              widget.viewModel.addHome(_id.text);
              Navigator.of(context).clearNamed(
                NavigationRouteNames.home,
                arguments: (id: _id.text),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _id.dispose();
    super.dispose();
  }
}
