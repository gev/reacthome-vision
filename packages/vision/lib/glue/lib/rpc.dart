import 'package:glue/module.dart';
import 'package:vision/glue/lib/rpc/post.dart';

/// Generic store module providing key-value storage
ModuleInfo rpcModule(Sink<String> sink) {
  return nativeModule('ffi.vision.rpc', [('post', post(sink))]);
}
