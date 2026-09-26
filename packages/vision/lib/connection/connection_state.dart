/// The current state of the connection.
enum ConnectionStatus { disconnected, connecting, connected }

typedef OnConnectionStatusChange = void Function(ConnectionStatus state);
