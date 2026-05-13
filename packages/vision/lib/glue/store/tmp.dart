import 'package:glue/ir.dart';
import 'package:vision/glue/store/glue_request.dart';
import 'package:vision/pub_sub/subscriber.dart';
import 'package:vision/state/store.dart';
import 'package:vision/state/stores/reactive_cache.dart';
import 'package:vision/state/stores/subscribable_store.dart';

ReactiveStore<String, Ir> tmp(Sink<String> sink) => SubscribableStore(
  Subscriber(store: ReactiveCache(), request: GlueRequest(sink)),
);
