import 'package:vision/glue/pub_sub/glue_subscriber.dart';
import 'package:vision/glue/stores/glue_subscribable.dart';
import 'package:vision/stores/reactive_cache.dart';
import 'package:vision/stores/subscribable.dart';

GlueSubscribable tmpStore(GlueSubscriber subscriber) =>
    ReactiveSubscribable(subscriber: subscriber, store: ReactiveCache());
