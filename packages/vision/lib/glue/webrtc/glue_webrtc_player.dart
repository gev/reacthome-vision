import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:glue/ir.dart';
import 'package:vision/widgets/media/webrtc/webrtc_player.dart';

class GlueWebRtcPlayer extends WebRtcPlayer<Ir> {
  GlueWebRtcPlayer(super.sessionId);

  @override
  Ir convertDescription(RTCSessionDescription description) =>
      IrObject({'sdp': toIr(description.sdp), 'type': toIr(description.type)});

  @override
  Ir convertCandidate(RTCIceCandidate candidate) => IrObject({
    'candidate': toIr(candidate.candidate),
    'sdpMid': toIr(candidate.sdpMid),
    'sdpMLineIndex': toIr(candidate.sdpMLineIndex),
  });
}
