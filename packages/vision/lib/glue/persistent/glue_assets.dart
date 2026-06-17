import 'dart:io';

import 'package:vision/glue/persistent/glue_asset_request.dart';
import 'package:vision/persistent/assets.dart';

Assets assets({
  required Sink<String> sink,
  required Directory path,
  required Directory tmp,
}) {
  return Assets(path: path, tmp: tmp, request: GlueAssetRequest(sink));
}
