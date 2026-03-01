import 'package:flutter/material.dart';
import 'package:vision/app.dart';
import 'package:vision/uuid.dart';

Widget makeStudioApp() =>
    makeApp(id: uuid(), title: 'Studio', host: '127.0.0.1', port: 3005);
