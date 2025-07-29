import 'package:flow/core/home/home.dart';
import 'package:flow/core/meta/meta.dart';
import 'package:flow/ui/dto/meta_ui_dto.dart';
import 'package:l10n/app_localizations.dart';

class HomeUiDto {
  final MetaUiDto meta;
  final bool hasProject;
  final String? address;

  HomeUiDto(AppLocalizations locale, {Home? home})
    : meta = MetaUiDto(
        locale,
        home?.meta ?? const Meta(),
        defaultName: (context) => locale.unknownHome,
      ),
      hasProject = home?.project != null,
      address = home?.address?.address;
}
