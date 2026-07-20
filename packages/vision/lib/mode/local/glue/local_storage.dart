import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:vision/glue/persistent/glue_db.dart';
import 'package:vision/glue/pub_sub/glue_subscriber.dart';
import 'package:vision/glue/stores/persistent_store.dart';
import 'package:vision/glue/stores/tmp_store.dart';
import 'package:vision/logger.dart';

class LocalStorage {
  late final GlueDb? glueDb;
  late final TmpStore tmpStore;
  late final DataStore dataStore;

  LocalStorage({
    required Directory path,
    required GlueSubscriber subscriber,
    required Sink<String> sink,
    required Logger log,
  }) {
    final dbDirectory = Directory(p.join(path.path, 'db'))
      ..createSync(recursive: true);

    glueDb = codeStore(dbDirectory, log);
    tmpStore = TmpStore(subscriber);
    dataStore = DataStore(dbDirectory, subscriber, log);
  }

  void dispose() {
    glueDb?.dispose();
    tmpStore.dispose();
    dataStore.dispose();
  }
}
