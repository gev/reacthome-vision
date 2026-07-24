import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:vision/glue/persistent/glue_assets.dart';
import 'package:vision/glue/persistent/glue_db.dart';
import 'package:vision/glue/pub_sub/glue_subscriber.dart';
import 'package:vision/glue/stores/local_persistent_store.dart';
import 'package:vision/glue/stores/remote_persistent_store.dart';
import 'package:vision/glue/stores/remote_store.dart';
import 'package:vision/logger.dart';
import 'package:vision/persistent/assets.dart';

class LiveStorage {
  late final GlueDb? codeDb;
  late final RemoteStore remoteStore;
  late final RemotePersistentStore remotePersistentStore;
  late final LocalPersistentStore localPersistentStore;
  late final Assets assets;

  LiveStorage({
    required Directory path,
    required GlueSubscriber subscriber,
    required Sink<String> sink,
    required Logger log,
  }) {
    final dbDirectory = Directory(p.join(path.path, 'db'))
      ..createSync(recursive: true);
    final assetsDirectory = Directory(p.join(path.path, 'assets'))
      ..createSync(recursive: true);
    final tmpDirectory = Directory(p.join(path.path, 'tmp'))
      ..createSync(recursive: true);

    codeDb = makeCodeDb(dbDirectory, log);
    remoteStore = RemoteStore(subscriber);
    remotePersistentStore = RemotePersistentStore(dbDirectory, subscriber, log);
    localPersistentStore = LocalPersistentStore(dbDirectory, log);
    assets = glueAssets(
      path: assetsDirectory,
      tmp: tmpDirectory,
      sink: sink,
      log: log,
    );
  }

  void dispose() {
    codeDb?.dispose();
    remoteStore.dispose();
    remotePersistentStore.dispose();
    localPersistentStore.dispose();
    assets.dispose();
  }
}
