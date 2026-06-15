import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:vision/glue/logger.dart';
import 'package:vision/glue/persistent/glue_db.dart';
import 'package:vision/glue/pub_sub/glue_subscriber.dart';
import 'package:vision/glue/stores/glue_reactive_cache.dart';
import 'package:vision/glue/stores/glue_reactive_db.dart';
import 'package:vision/glue/stores/glue_subscribable.dart';
import 'package:vision/persistent/raw_db.dart';
import 'package:vision/store/subscribable.dart';

GlueSubscribable dataStore(
  Directory path,
  GlueSubscriber subscriber,
  Logger log,
) {
  final glueDb = _dbStore('data', path, log);
  if (glueDb != null) {
    final store = GlueReactiveDb(db: glueDb, log: log);
    return ReactiveSubscribable(
      subscriber: subscriber,
      lookupStore: store,
      versionStore: store,
      putStore: store,
    );
  } else {
    log.warning('Fallback to temporary store');
    final store = GlueReactiveCache();
    return ReactiveSubscribable(
      subscriber: subscriber,
      lookupStore: store,
      versionStore: store,
      putStore: store,
    );
  }
}

GlueDb? codeStore(Directory path, Logger log) => _dbStore('code', path, log);

GlueDb? _dbStore(String name, Directory path, Logger log) {
  try {
    final dbDirectory = Directory(p.join(path.absolute.path, 'db'));
    final dbPath = p.setExtension(p.join(dbDirectory.path, name), '.db');
    dbDirectory.createSync(recursive: true);
    return GlueDb(db: RawDb(path: dbPath));
  } catch (error) {
    log.error(error);
    return null;
  }
}
