import 'package:fluent_ui/fluent_ui.dart';

class TextFieldFluent extends StatelessWidget {
  final TextEditingController? controller;
  final String? placeholder;
  final bool autofocus;

  const TextFieldFluent({
    this.controller,
    this.placeholder,
    this.autofocus = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextBox(
      controller: controller,
      autofocus: autofocus,
      placeholder: placeholder,
    );
  }
}
