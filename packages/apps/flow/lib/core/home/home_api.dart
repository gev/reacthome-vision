import 'dart:io';

import 'package:flow/core/home/home.dart';
import 'package:flow/core/meta/meta.dart';

abstract interface class HomeApi {
  Iterable<String> get homes;

  Home? getHomeById(String id);

  void addHome(
    String id, {
    required Meta meta,
    InternetAddress? address,
    String? project,
  });

  void updateHome(
    String id, {
    required Meta meta,
    InternetAddress? address,
    String? project,
  });

  void removeHome(String id);

  void confirmHome(String id);
}
