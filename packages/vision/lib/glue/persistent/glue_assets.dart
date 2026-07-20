import 'dart:io';

import 'package:vision/glue/persistent/glue_asset_request.dart';
import 'package:vision/logger.dart';
import 'package:vision/persistent/assets.dart';

Assets glueAssets({
  required Sink<String> sink,
  required Directory path,
  required Directory tmp,
  required Logger log,
}) {
  return Assets(
    path: path,
    tmp: tmp,
    request: GlueAssetRequest(sink),
    log: log,
  );
}
