import 'package:flutter/material.dart';

class VisionApp extends StatelessWidget {
  final String title;
  const VisionApp({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Scaffold(body: Center(child: Text('Vision'))),
    );
  }
}
