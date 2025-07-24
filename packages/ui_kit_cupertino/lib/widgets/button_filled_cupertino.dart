import 'package:flutter/cupertino.dart';

class ButtonFilledCupertino extends StatelessWidget {
  final String label;
  final void Function()? onPressed;

  const ButtonFilledCupertino({required this.label, this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton.filled(onPressed: onPressed, child: Text(label));
  }
}
