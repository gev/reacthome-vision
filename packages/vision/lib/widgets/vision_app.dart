import 'package:flutter/material.dart';
import 'package:vision/glue/widgets/glue_widget.dart';
import 'package:vision/widgets/screen.dart';
import 'package:vision/widgets/theme.dart';

class VisionApp extends StatelessWidget {
  final String title;

  const VisionApp({required this.title, super.key});

  final _main = '''
    (listen 
      (lookup store.cache "main" placeholder)
      (lambda (main) main))
  ''';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      themeMode: ThemeMode.system,
      theme: makeTheme(Colors.blue, Brightness.light),
      darkTheme: makeTheme(Colors.blue, Brightness.dark),
      home: Screen(body: GlueWidget(glue: _main)),
    );
  }
}
