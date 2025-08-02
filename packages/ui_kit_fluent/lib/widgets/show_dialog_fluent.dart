import 'package:fluent_ui/fluent_ui.dart';

Future<T?> showDialogFluent<T>(
  BuildContext context, {
  required WidgetBuilder builder,
}) => showDialog<T>(context: context, builder: builder);
