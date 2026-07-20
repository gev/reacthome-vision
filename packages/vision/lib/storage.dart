import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:vision/glue/persistent/glue_assets.dart';
import 'package:vision/glue/persistent/glue_db.dart';
import 'package:vision/glue/pub_sub/glue_subscriber.dart';
import 'package:vision/glue/stores/persistent_store.dart';
import 'package:vision/glue/stores/tmp_store.dart';
import 'package:vision/logger.dart';
import 'package:vision/persistent/assets.dart';

class Storage {
  late final GlueDb? glueDb;
  late final TmpStore tmpStore;
  late final DataStore dataStore;
  late final Assets assets;

  Storage({
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

    glueDb = codeStore(dbDirectory, log);
    tmpStore = TmpStore(subscriber);
    dataStore = DataStore(dbDirectory, subscriber, log);
    assets = glueAssets(
      path: assetsDirectory,
      tmp: tmpDirectory,
      sink: sink,
      log: log,
    );
  }

  void dispose() {
    glueDb?.dispose();
    tmpStore.dispose();
    dataStore.dispose();
    assets.dispose();
  }
}
