import 'package:flow/ui/dto/meta_ui_dto.dart';
import 'package:flutter/widgets.dart';
import 'package:l10n/app_localizations.dart';
import 'package:ui_kit/widgets.dart';

class MetaProps extends StatelessWidget {
  final String id;
  final MetaUiDto meta;

  const MetaProps(this.id, this.meta, {super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return ListSection(
      children: [
        ListTile(title: Text(id)),
        ListTile(title: Text(meta.title), trailing: Text(locale.title)),
        ListTile(title: Text(meta.code), trailing: Text(locale.code)),
      ],
    );
  }
}
