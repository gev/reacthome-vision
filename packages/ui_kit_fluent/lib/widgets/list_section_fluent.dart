import 'package:fluent_ui/fluent_ui.dart';
import 'package:ui_kit/widgets.dart';

class ListSectionFluent extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  final bool hasLeading;

  const ListSectionFluent({
    this.title,
    required this.children,
    this.hasLeading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (title != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListSectionTitleMaterial(title!),
          ListSectionCardMaterial.withTitle(children),
        ],
      );
    } else {
      return UI.DefaultPadding.fullWidth(
        child: Card(
          margin: EdgeInsets.zero,
          child: Column(children: children),
        ),
      );
    }
  }
}

class ListSectionCardMaterial extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsetsGeometry padding;

  ListSectionCardMaterial(this.children, {super.key})
    : padding = UI.DefaultPadding.edgeInsets;

  ListSectionCardMaterial.withTitle(this.children, {super.key})
    : padding = EdgeInsetsDirectional.fromSTEB(
        UI.DefaultPadding.start,
        4,
        UI.DefaultPadding.end,
        UI.DefaultPadding.bottom,
      );

  @override
  Widget build(BuildContext context) => Padding(
    padding: padding,
    child: Card(
      margin: EdgeInsets.zero,
      child: Column(children: children),
    ),
  );
}

class ListSectionTitleMaterial extends StatelessWidget {
  final String title;

  const ListSectionTitleMaterial(this.title, {super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsetsDirectional.fromSTEB(
      UI.DefaultPadding.start,
      UI.DefaultPadding.top,
      UI.DefaultPadding.end,
      0,
    ),
    child: Text(title, style: FluentTheme.of(context).typography.title!),
  );
}
