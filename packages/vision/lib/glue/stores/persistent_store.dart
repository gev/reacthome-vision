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
  final glueDb = _dbStore('code', path, log);
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
    path.createSync(recursive: true);
    final pathDb = p.setExtension(p.join(path.absolute.path, name), '.db');
    print(pathDb);
    final rawDb = RawDb(path: pathDb);
    return GlueDb(db: rawDb);
  } catch (error) {
    print(error);
    log.error(error);
    return null;
  }
}
