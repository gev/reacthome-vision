import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

typedef WebRtcAnswer = ({
  RTCSessionDescription description,
  ValueNotifier<List<RTCIceCandidate>> candidates,
});
