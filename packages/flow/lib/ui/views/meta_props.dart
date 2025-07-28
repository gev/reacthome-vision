import 'package:flow/l10n/app_localizations.dart';
import 'package:flow/ui/dto/meta_ui_dto.dart';
import 'package:flow/ui_kit/kit.dart';
import 'package:flutter/widgets.dart';

class MetaProps extends StatelessWidget {
  final String id;
  final MetaUiDto meta;

  const MetaProps(this.id, this.meta, {super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return list.section(
      context,
      children: [
        list.tile(title: Text(id)),
        list.tile(title: Text(meta.title), trailing: Text(locale.title)),
        list.tile(title: Text(meta.code), trailing: Text(locale.code)),
      ],
    );
  }
}
