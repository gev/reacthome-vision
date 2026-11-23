/// ICE server configuration accepted by a WebRTC peer connection.
class WebRtcIceServer {
  const WebRtcIceServer({
    required this.urls,
    this.username,
    this.credential,
  });

  final List<String> urls;
  final String? username;
  final String? credential;

  Map<String, Object?> toMap() => {
    'urls': urls,
    if (username != null) 'username': username,
    if (credential != null) 'credential': credential,
  };
}
