import 'package:glue/ir.dart';
import 'package:vision/widgets/media/webrtc/webrtc_ice_transport_policy.dart';

final Ir webrtcIceTransportPolicy = IrObject({
  'all': IrNativeValue(Value(WebRtcIceTransportPolicy.all)),
  'relay': IrNativeValue(Value(WebRtcIceTransportPolicy.relay)),
});
