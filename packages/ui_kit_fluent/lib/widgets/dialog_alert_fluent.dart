import 'package:fluent_ui/fluent_ui.dart';

class AlertDialogFluent extends StatelessWidget {
  final Widget? title;
  final Widget? content;
  final List<Widget> actions;

  const AlertDialogFluent({
    this.title,
    this.content,
    required this.actions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ContentDialog(title: title, content: content, actions: actions);
  }
}
