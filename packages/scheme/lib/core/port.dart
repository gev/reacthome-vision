enum PortType { sensor, actuator, dummy }

class Port {
  final PortType type;
  Port({required this.type});
}
