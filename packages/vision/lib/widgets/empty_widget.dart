import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  final String title;
  const EmptyWidget(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator.adaptive());
  }
}
