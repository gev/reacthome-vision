import 'dart:convert';
import 'dart:io';

Future<void> sendProbe({required String probeGroup, required int port}) async {
  final probeMessage = utf8.encode('(probe :version 1)');
  final group = InternetAddress(probeGroup);

  final interfaces = await NetworkInterface.list(
    includeLoopback: false,
    type: InternetAddressType.IPv4,
  );

  for (var interface in interfaces) {
    for (var addr in interface.addresses) {
      try {
        final socket = await RawDatagramSocket.bind(addr, 0);
        socket.send(probeMessage, group, port);
        socket.close();
      } catch (_) {}
    }
  }
}
