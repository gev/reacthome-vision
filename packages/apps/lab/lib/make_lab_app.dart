import 'package:flutter/material.dart';
import 'package:vision/app.dart';
import 'package:vision/uuid.dart';

Widget makeLabApp() =>
    makeApp(id: uuid(), title: 'Lab', host: '127.0.0.1', port: 3005);
