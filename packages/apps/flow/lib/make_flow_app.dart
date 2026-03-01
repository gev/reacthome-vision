import 'package:flutter/material.dart';
import 'package:vision/app.dart';
import 'package:vision/uuid.dart';

Widget makeFlowApp() =>
    makeApp(id: uuid(), title: 'Flow', host: '127.0.0.1', port: 3005);
