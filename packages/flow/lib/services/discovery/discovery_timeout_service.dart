import 'package:flow/common/bus/bus_listener.dart';
import 'package:flow/core/home/home_api.dart';
import 'package:flow/core/home/home_event.dart';
import 'package:flow/util/timeout.dart';

class DiscoveryTimeoutService extends BusListener<HomeEvent> {
  final HomeApi homeApi;
  final Duration timeout;

  DiscoveryTimeoutService({
    required super.eventSource,
    required this.homeApi,
    required this.timeout,
  });

  final timeouts = Timeout<String>();

  @override
  void handle(HomeEvent event) {
    switch (event) {
      case HomeRenewEvent e:
        _setTimeout(e.id);
      case HomeRemovedEvent e:
        _cancelTimeout(e.id);
      default:
    }
  }

  void _setTimeout(String id) => timeouts.set(
    id,
    duration: timeout,
    execute: () => homeApi.removeHome(id),
  );

  void _cancelTimeout(String id) => timeouts.cancel(id);
}
