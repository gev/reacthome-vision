enum ConnectorType { sensor, actuator, dummy }

class Connector {
  final ConnectorType type;
  Connector({required this.type});
}
