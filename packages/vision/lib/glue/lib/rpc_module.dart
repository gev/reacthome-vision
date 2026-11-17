import 'dart:typed_data';

import 'package:glue/module.dart';
import 'package:vision/glue/lib/rpc/post.dart';

/// RPC module providing remote procedure call
ModuleInfo rpcModule(Sink<Uint8List> sink) {
  return nativeModule('ffi.vision.rpc', [('post', post(sink))]);
}
