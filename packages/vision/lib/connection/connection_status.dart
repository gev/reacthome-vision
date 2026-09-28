enum ConnectionStatus { disconnected, connecting, connected }

typedef OnConnectionStatusChanged = void Function(ConnectionStatus state);
