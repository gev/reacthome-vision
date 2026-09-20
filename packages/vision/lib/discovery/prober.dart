import 'dart:convert';
import 'dart:io';

import 'package:glue/ast.dart';
import 'package:glue/serialize.dart';

Future<void> sendProbe({
  required NetworkInterface interface,
  required String probeGroup,
  required int port,
}) async {
  final group = InternetAddress(probeGroup);

  for (var addr in interface.addresses) {
    try {
      final socket = await RawDatagramSocket.bind(addr, 0);
      socket.send(_probeMessage, group, port);
      socket.close();
    } catch (_) {}
  }
}

final _probeMessage = utf8.encode(
  serializeAst(
    ListAst([
      SymbolAst("probe"),
      ObjectAst({"version": IntegerAst(1)}),
    ]),
  ),
);
