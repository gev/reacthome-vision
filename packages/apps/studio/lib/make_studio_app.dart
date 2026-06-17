import 'package:flutter/material.dart';
import 'package:vision/app.dart';

Future<Widget> makeStudioApp() =>
    makeApp(title: 'Studio', host: '127.0.0.1', port: 3005);
