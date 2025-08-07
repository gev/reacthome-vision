import 'package:fluent_ui/fluent_ui.dart';

class AppDesktopFluent extends StatelessWidget {
  final Widget? toolbar;
  final Widget? start;
  final Widget? end;
  final Widget? body;

  const AppDesktopFluent({
    this.toolbar,
    this.start,
    this.end,
    this.body,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(title: toolbar),
      pane: NavigationPane(
        displayMode: PaneDisplayMode.open,
        items: [
          PaneItem(
            icon: const Icon(FluentIcons.home),
            title: const Text('Home'),
            body: body!,
          ),
        ],
      ),
      // content: body,
    );
  }
}
