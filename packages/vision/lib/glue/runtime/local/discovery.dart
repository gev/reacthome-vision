import 'dart:io';

import 'package:glue/context.dart';
import 'package:glue/runtime.dart';
import 'package:vision/discovery/discovery.dart';
import 'package:vision/glue/discovery_store.dart';
import 'package:vision/glue/glue_controller.dart';
import 'package:vision/glue/runtime/discovery/discovery_env.dart';
import 'package:vision/glue/runtime/local/local_logger.dart';

void runDiscovery(DiscoveryStore store) {
  final log = LocalLogger();
  final glueController = GlueController(log: log);
  final initialRuntime = Runtime.initial(makeDiscoveryEnv(store));
  startDiscovery(
    onAnnounce: (Datagram datagram) {
      try {
        final runtime = initialRuntime.copyWith(
          context: putToContext<InternetAddress>(
            initialRuntime.context,
            datagram.address,
          ),
        );
        glueController.runGlue(datagram.data, runtime);
      } catch (e) {
        log.error(e.toString());
      }
    },
  );
}
