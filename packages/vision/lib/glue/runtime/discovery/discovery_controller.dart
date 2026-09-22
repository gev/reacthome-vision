import 'dart:developer';
import 'dart:io';

import 'package:glue/runtime.dart';
import 'package:vision/discovery/discovery.dart';
import 'package:vision/glue/discovery_store.dart';
import 'package:vision/glue/glue_controller.dart';
import 'package:vision/glue/runtime/discovery/discovery_env.dart';
import 'package:vision/logger.dart';

class DiscoveryController {
  late final GlueController _glueController;
  late final Runtime _runtime;

  DiscoveryController({required DiscoveryStore store, required Logger log}) {
    _glueController = GlueController(log: log);
    _runtime = Runtime.initial(makeDiscoveryEnv(store));
    startDiscovery(onAnnounce: _onData);
  }

  void _onData(Datagram datagram) {
    try {
      _glueController.runGlue(datagram.data, _runtime);
    } catch (e) {
      log(e.toString());
    }
  }
}
