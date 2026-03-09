import 'package:flutter/material.dart';
import 'package:vision/glue/widgets/glue_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final _main = '''
    (listen 
      (lookup store.cache "main" placeholder)
      (lambda (main) main))
  ''';

  @override
  Widget build(BuildContext context) {
    return GlueWidget(glue: _main);
  }
}
