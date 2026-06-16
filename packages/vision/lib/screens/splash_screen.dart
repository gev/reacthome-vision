import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vision/widgets/logo.dart';
import 'package:vision/widgets/screen.dart';

class SplashScreen extends StatefulWidget {
  final String _title;
  final String _route;

  const SplashScreen({required this._title, required this._route, super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _splashTimer;

  @override
  void initState() {
    super.initState();
    _loop();
  }

  void _loop() {
    _splashTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        try {
          Navigator.of(context).pushReplacementNamed(widget._route);
        } catch (_) {
          _loop();
        }
      }
    });
  }

  @override
  void dispose() {
    _splashTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Logo(width: 64),
            const SizedBox(height: 16),
            Text(widget._title),
            const SizedBox(height: 16),
            const CircularProgressIndicator.adaptive(),
          ],
        ),
      ),
    );
  }
}
