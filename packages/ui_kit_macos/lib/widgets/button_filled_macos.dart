import 'package:flutter/cupertino.dart';

class ButtonFilledMacOS extends StatelessWidget {
  final String label;
  final void Function()? onPressed;

  const ButtonFilledMacOS({required this.label, this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton.filled(onPressed: onPressed, child: Text(label));
  }
}
