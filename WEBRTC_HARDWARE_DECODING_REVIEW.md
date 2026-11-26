# WebRTC hardware decoding review

## Goal

Reduce CPU usage for WebRTC video on Raspberry Pi 4 and, later, Rockchip devices by using the platform's hardware H.264 decoder. Preserve WebRTC signaling, ICE, encryption, and the existing Vision player API.

## Observations

- The RTSP/FVP player works on macOS and Raspberry Pi. Its direct FVP player configures Linux decoder priorities as `V4L2M2M` and `rockchip`; the eLinux app also configures those priorities for FVP's video-player integration.
- On the Pi, the user measured approximately 40–50% CPU for RTSP/FVP and 80–90% for WebRTC, on a scale where four fully occupied cores represent 400%. These are observations, not a controlled benchmark.
- With only RTSP/FVP playing, `flow` held `/dev/video10`, the Pi's `bcm2835-codec-decode` V4L2 device. With only WebRTC playing, `fuser` returned no owner. This supports, but does not independently prove, that the WebRTC session used software decoding. The exact selected decoder has not been measured.
- A WebRTC session received video and decoded frames on the Pi. Passing the actual video track ID to `RTCVideoRenderer.setSrcObject` restored rendering. That fix is independent of hardware decoder selection.
- The previous connection logs included a separate reconnect failure. That is a player lifecycle issue to investigate separately.

## Current architecture

The Vision WebRTC player uses `flutter_webrtc` (`^1.6.3`). Its eLinux plugin links a prebuilt `libwebrtc.so`; the installed package's manifest specifies `libwebrtc.m150.7871.07`. The library receives and decrypts WebRTC media, assembles compressed frames, and selects a video decoder. WebRTC encryption does not prevent passing decrypted compressed frames to a hardware decoder.

The RTSP player uses FVP/MDK and its own FFmpeg and hardware decoder integration. Its FVP settings do not configure WebRTC's native library. Upstream WebRTC has an H.264 decoder implemented with FFmpeg, but the exact decoder factory and build flags for the installed m150 binary remain to be verified. [WebRTC H.264 decoder](https://webrtc.googlesource.com/src.git/+/0fa90887c5bf15aa6e73c2df78cae31feb82fa54/modules/video_coding/codecs/h264/h264_decoder_impl.cc) · [MDK Raspberry Pi decoder setup](https://github.com/wang-bin/mdk-sdk)

The eLinux `flutter_webrtc` renderer uses a pixel-buffer texture and converts video frames to ARGB. Hardware decoding could reduce decoding CPU while leaving frame conversion and texture copies as significant costs. Measure both before pursuing a separate zero-copy rendering change.

## Unknowns

- The selected WebRTC decoder and whether `decoderImplementation` and `powerEfficientDecoder` are exposed in this native build.
- The matching m150 source revisions, decoder factory, build flags, and supported binary interface.
- Whether the Pi's system FFmpeg and its V4L2 decoder can be used by a custom WebRTC decoder without conflicting with the library's bundled FFmpeg symbols or versions.
- The format, memory ownership, and copy costs of output frames when adapting V4L2 or FFmpeg output to WebRTC.
- Hardware behavior under multiple streams, resolution changes, packet loss, reconnects, and decoder resource exhaustion.

The implementation task is in [WEBRTC_HARDWARE_DECODING_TASK.md](WEBRTC_HARDWARE_DECODING_TASK.md).
