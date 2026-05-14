import 'package:glue/ir.dart';
import 'package:vision/glue/store/glue_request.dart';
import 'package:vision/pub_sub/subscriber.dart';
import 'package:vision/stores/reactive_cache.dart';
import 'package:vision/stores/store.dart';
import 'package:vision/stores/subscribable_store.dart';

ReactiveStore<String, Ir> tmp(Sink<String> sink) => SubscribableStore(
  Subscriber(store: ReactiveCache(), request: GlueRequest(sink)),
);
