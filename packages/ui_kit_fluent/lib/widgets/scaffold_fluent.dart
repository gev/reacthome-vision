import 'package:fluent_ui/fluent_ui.dart';

class ScaffoldFluent extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;

  const ScaffoldFluent({this.appBar, required this.body, super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(header: appBar, content: body);
  }
}
