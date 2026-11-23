import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

/// Local signaling data produced while responding to a remote offer.
class WebRtcNegotiation extends ChangeNotifier {
  RTCSessionDescription? _answer;
  final List<RTCIceCandidate> _iceCandidates = [];
  bool _isDisposed = false;

  RTCSessionDescription? get answer => _answer;

  List<RTCIceCandidate> get iceCandidates =>
      List<RTCIceCandidate>.unmodifiable(_iceCandidates);

  void setAnswer(RTCSessionDescription answer) {
    if (_isDisposed) return;
    _answer = answer;
    notifyListeners();
  }

  void addIceCandidate(RTCIceCandidate candidate) {
    if (_isDisposed) return;
    _iceCandidates.add(candidate);
    notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
