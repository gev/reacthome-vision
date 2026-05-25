/// The current state of the connection.
enum SessionState { disconnected, connecting, connected }

typedef OnSessionStateChange = void Function(SessionState state);
