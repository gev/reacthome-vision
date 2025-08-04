import 'package:fluent_ui/fluent_ui.dart';
import 'package:ui_kit/icons.dart';

class IconsFluent implements IconContainer {
  const IconsFluent();

  @override
  IconData get add => FluentIcons.add;

  @override
  IconData get delete => FluentIcons.delete;

  @override
  IconData get search => FluentIcons.search;

  @override
  IconData get settings => FluentIcons.settings;

  @override
  IconData get wifi => FluentIcons.wifi;

  @override
  IconKind get home =>
      (filled: FluentIcons.home_solid, outlined: FluentIcons.home);
}
