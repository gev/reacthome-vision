import 'package:glue/ir.dart';
import 'package:vision/pub_sub/subscriber.dart';
import 'package:vision/stores/reactive_cache.dart';
import 'package:vision/stores/store.dart';
import 'package:vision/stores/subscribable_store.dart';

ReactiveStore<String, Ir> tmp(Subscriber<String> subscriber) =>
    SubscribableStore(subscriber: subscriber, store: ReactiveCache());
