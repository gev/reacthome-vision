import 'package:flutter/material.dart';
import 'package:vision/glue/widgets/glue_widget.dart';
import 'package:vision/widgets/screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final _main = '''
    (listen 
      (lookup store.cache "main" placeholder)
      (lambda (main) main))
  ''';

  @override
  Widget build(BuildContext context) {
    return Screen(body: GlueWidget(glue: _main));
  }
}
