import 'dart:async';
import 'dart:convert';
import 'dart:io';

typedef OnAnnounce = void Function(String message, InternetAddress sender);

Future<void> startScanner({
  required String announceGroup,
  required int port,
  required OnAnnounce onAnnounce,
  Duration timeout = const Duration(seconds: 2),
}) async {
  try {
    await _listenToMulticast(
      announceGroup: announceGroup,
      port: port,
      onAnnounce: onAnnounce,
      timeout: timeout,
    );
  } finally {
    Timer(timeout, () {
      startScanner(
        announceGroup: announceGroup,
        port: port,
        onAnnounce: onAnnounce,
        timeout: timeout,
      );
    });
  }
}

Future<void> _listenToMulticast({
  required String announceGroup,
  required int port,
  required OnAnnounce onAnnounce,
  required Duration timeout,
}) async {
  final socket = await _bindSocket(port);
  final completer = Completer<void>();
  final group = InternetAddress(announceGroup);
  final joinedInterfaces = <String>{};

  await _updateInterfaces(socket, group, joinedInterfaces);
  final interfacePollTimer = Timer.periodic(timeout, (_) {
    _updateInterfaces(socket, group, joinedInterfaces);
  });

  try {
    socket.listen(
      (event) => _handleSocketEvent(event, socket, onAnnounce),
      onError: (_) => _completeSafely(completer),
      onDone: () => _completeSafely(completer),
      cancelOnError: true,
    );

    await completer.future;
  } finally {
    interfacePollTimer.cancel();
    try {
      socket.close();
    } catch (_) {}
  }
}

Future<RawDatagramSocket> _bindSocket(int port) async {
  final socket = await RawDatagramSocket.bind(
    InternetAddress.anyIPv4,
    port,
    reuseAddress: true,
    reusePort: true,
  );
  return socket;
}

Future<void> _updateInterfaces(
  RawDatagramSocket socket,
  InternetAddress group,
  Set<String> joinedInterfaces,
) async {
  try {
    final interfaces = await NetworkInterface.list(includeLoopback: false);
    for (var interface in interfaces) {
      if (!joinedInterfaces.contains(interface.name)) {
        try {
          socket.joinMulticast(group, interface);
          joinedInterfaces.add(interface.name);
        } catch (_) {}
      }
    }
  } catch (_) {}
}

void _handleSocketEvent(
  RawSocketEvent event,
  RawDatagramSocket socket,
  OnAnnounce onAnnounce,
) {
  if (event == RawSocketEvent.read) {
    final datagram = socket.receive();
    if (datagram != null) {
      final message = utf8.decode(datagram.data);
      onAnnounce(message, datagram.address);
    }
  }
}

void _completeSafely(Completer completer) {
  if (!completer.isCompleted) {
    completer.complete();
  }
}
