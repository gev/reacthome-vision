import 'package:flow/controllers/discovery/discovery_controller.dart';
import 'package:flow/make/core/discovery_factory.dart';

class DiscoveryControllerFactory {
  static DiscoveryController make() =>
      DiscoveryController(homeApi: DiscoveryFactory.makeHomeApi());
}
