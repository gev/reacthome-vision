import 'package:flutter/material.dart';
import 'package:vision/widgets/statusbar.dart';

class Screen extends StatelessWidget {
  final Widget body;
  const Screen({required this.body, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(child: body),
          Statusbar(),
        ],
      ),
    );
  }
}
