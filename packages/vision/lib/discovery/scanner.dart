import 'dart:async';
import 'dart:convert';
import 'dart:io';

const defaultDiscoveryTimeout = Duration(seconds: 2);

typedef OnAnnounce = void Function(String message, InternetAddress sender);
typedef OnJoin = void Function(NetworkInterface interface);

Future<void> startScanner({
  required String announceGroup,
  required int port,
  required OnAnnounce onAnnounce,
  required OnJoin onJoin,
  Duration timeout = defaultDiscoveryTimeout,
}) async {
  try {
    await _listenToMulticast(announceGroup, port, onAnnounce, onJoin, timeout);
  } finally {
    Timer(timeout, () {
      startScanner(
        announceGroup: announceGroup,
        port: port,
        onAnnounce: onAnnounce,
        onJoin: onJoin,
        timeout: timeout,
      );
    });
  }
}

Future<void> _listenToMulticast(
  String announceGroup,
  int port,
  OnAnnounce onAnnounce,
  OnJoin onJoin,
  Duration timeout,
) async {
  final socket = await _bindSocket(port);
  final completer = Completer();
  final group = InternetAddress(announceGroup);
  final joinedInterfaces = <int, NetworkInterface>{};

  await _updateInterfaces(socket, group, joinedInterfaces, onJoin);
  final interfacePollTimer = Timer.periodic(timeout, (_) {
    _updateInterfaces(socket, group, joinedInterfaces, onJoin);
  });

  try {
    socket.listen(
      (event) => _handleSocketEvent(event, socket, onAnnounce),
      onError: (_) {
        _completeSafely(completer);
      },
      onDone: () {
        _completeSafely(completer);
      },
      cancelOnError: true,
    );
    await completer.future;
  } finally {
    interfacePollTimer.cancel();
    try {
      socket.leaveMulticast(group);
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
  Map<int, NetworkInterface> joined,
  OnJoin onJoin,
) async {
  try {
    final interfaces = await NetworkInterface.list(includeLoopback: false);
    final indexes = interfaces.map((i) => i.index);
    for (final entry in joined.entries) {
      if (!indexes.contains(entry.key)) {
        socket.leaveMulticast(group, entry.value);
        joined.remove(entry.key);
      }
    }
    for (final interface in interfaces) {
      if (!joined.keys.contains(interface.index)) {
        try {
          socket.joinMulticast(group, interface);
          joined[interface.index] = interface;
          onJoin(interface);
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
