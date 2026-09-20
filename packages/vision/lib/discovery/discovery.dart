import 'dart:io';

import 'package:vision/discovery/prober.dart';
import 'package:vision/discovery/scanner.dart';

void startDiscovery({
  String probeGroup = "239.0.20.27",
  int probePort = 2027,
  String announceGroup = "239.0.20.26",
  int announcePort = 2026,
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
