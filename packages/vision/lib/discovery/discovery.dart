import 'dart:io';

import 'package:vision/discovery/prober.dart';
import 'package:vision/discovery/scanner.dart';

void startDiscovery({
  required String probeGroup,
  required int probePort,
  required String announceGroup,
  required int announcePort,
  required OnAnnounce onAnnounce,
  Duration timeout = defaultDiscoveryTimeout,
}) {
  startScanner(
    announceGroup: announceGroup,
    port: announcePort,
    onAnnounce: onAnnounce,
    timeout: timeout,
    onJoin: (NetworkInterface interface) {
      sendProbe(interface: interface, probeGroup: probeGroup, port: probePort);
    },
  );
}
