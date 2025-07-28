import 'dart:io';

import 'package:common/entity.dart';
import 'package:flow/core/meta/meta.dart';

abstract interface class Home implements Entity<String> {
  Meta get meta;
  InternetAddress? get address;
  String? get project;
}
