import 'package:glue/module.dart';
import 'package:vision/glue/lib/rpc/post.dart';

/// RPC module providing remote procedure call
ModuleInfo rpcModule(Sink<String> sink) {
  return nativeModule('ffi.vision.rpc', [('post', post(sink))]);
}
