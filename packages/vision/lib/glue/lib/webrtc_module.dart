import 'package:glue/module.dart';
import 'package:vision/glue/lib/webrtc/webrtc_accept.dart';
import 'package:vision/glue/lib/webrtc/webrtc_add_candidate.dart';
import 'package:vision/glue/lib/webrtc/webrtc_ice_server.dart';
import 'package:vision/glue/lib/webrtc/webrtc_ice_transport_policy.dart';
import 'package:vision/glue/lib/webrtc/webrtc_video_player.dart';

final ModuleInfo webrtcModule = nativeModule('ffi.vision.webrtc', [
  ('webrtc-video-player', webRtcVideoPlayer),
  ('webrtc-accept', webRtcAccept),
  ('webrtc-add-candidate', webRtcAddCandidate),
  ('ice-server', iceServer),
  ('ice-transport-policy', webrtcIceTransportPolicy),
]);
