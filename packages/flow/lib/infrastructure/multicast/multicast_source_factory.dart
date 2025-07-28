import 'dart:async';
import 'dart:io';

import 'package:flow/common/handler.dart';
import 'package:flow/infrastructure/multicast/multicast_source.dart';

class MulticastSourceFactory {
  final InternetAddress group;
  final int port;
  final Handler<Datagram> controller;

  const MulticastSourceFactory({
    required this.group,
    required this.port,
    required this.controller,
  });

  Future<MulticastSource> create() =>
      MulticastSource.create(group, port, controller);
}
