import 'package:flutter/material.dart';
import 'package:ui_kit/widgets.dart';
import 'package:yaru/yaru.dart';

class ListSectionYaru extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  final bool hasLeading;

  const ListSectionYaru({
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
        child: YaruSection(
          margin: EdgeInsets.zero,
          child: Column(
            children: ListTile.divideTiles(
              context: context,
              tiles: children,
            ).toList(),
          ),
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
    child: YaruSection(
      margin: EdgeInsets.zero,
      child: Column(
        children: ListTile.divideTiles(
          context: context,
          tiles: children,
        ).toList(),
      ),
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
    child: Text(title, style: Theme.of(context).textTheme.titleMedium),
  );
}
