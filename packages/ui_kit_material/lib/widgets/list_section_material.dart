import 'package:flutter/material.dart';
import 'package:ui_kit/layout_paddings.dart';

class ListSectionMaterial extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  final bool hasLeading;

  const ListSectionMaterial({
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
      return DefaultPadding.fullWidth(
        child: Card(
          shape: const ContinuousRectangleBorder(),
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
    : padding = DefaultPadding.edgeInsets;

  ListSectionCardMaterial.withTitle(this.children, {super.key})
    : padding = EdgeInsetsDirectional.fromSTEB(
        DefaultPadding.start,
        4,
        DefaultPadding.end,
        DefaultPadding.bottom,
      );

  @override
  Widget build(BuildContext context) => Padding(
    padding: padding,
    child: Card(
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
      DefaultPadding.start,
      DefaultPadding.top,
      DefaultPadding.end,
      0,
    ),
    child: Text(title, style: Theme.of(context).textTheme.titleMedium),
  );
}
