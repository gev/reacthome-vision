# Implementation task: hardware H.264 decoding for eLinux WebRTC

## Outcome

Receive H.264 WebRTC video on Raspberry Pi 4 using its V4L2 hardware decoder, while preserving the existing `flutter_webrtc` and Vision signaling interfaces. Design the integration so a Rockchip backend can be added or selected without changing the signaling protocol.

## Investigation and design

1. Capture a baseline on the Pi using one camera, with resolution, frame rate, bitrate, CPU usage, dropped frames, and latency recorded. Capture WebRTC inbound video `decoderImplementation`, `powerEfficientDecoder`, `framesDecoded`, and decode timing when available. Record which process has `/dev/video10` open.
2. Identify the exact source revisions and build configuration for `libwebrtc.m150.7871.07`. Trace peer connection factory creation, H.264 codec negotiation, decoder factory registration, and how `flutter_webrtc` links and packages the library. Establish ABI compatibility before replacing it.
3. Evaluate a WebRTC `VideoDecoder` backed by the Pi's V4L2 decoder or the installed patched FFmpeg. Check codec profiles, H.264 packetization and access-unit format, timestamps, keyframes, asynchronous buffers, frame conversion, library dependencies, and FFmpeg symbol/version isolation. Compare the integration cost with an existing compatible implementation if one is available.
4. Document the chosen integration point and how the decoder will fall back when hardware is unavailable, unsupported, or exhausted. Preserve existing behavior on non-eLinux platforms.

## Implementation

- Implement and register an H.264 hardware decoder in the appropriate native WebRTC factory. Prefer the Pi backend when supported and retain a working software fallback.
- Handle packet loss, decoder errors, keyframe recovery, resolution changes, reset, resource release, concurrent sessions, and stream shutdown. Preserve timestamps and ensure buffer ownership is safe across threads.
- Produce a reproducible ARM64 build of the matching native library. Provide an explicit eLinux build configuration for selecting and packaging it and its required dependencies. Keep the stock library usable. Update `flutter_webrtc` packaging only if the existing plugin cannot consume the compatible binary.
- Expose or log the actual selected decoder and hardware fallback reason through an appropriate diagnostic path. Avoid logging credentials or SDP.
- Retain the current WebRTC signaling, ICE, audio, renderer, and Dart player API unless a specific change is required by the integration.

## Validation and acceptance

- On Raspberry Pi 4, a WebRTC H.264 camera plays reliably and the selected hardware decoder is confirmed through decoder diagnostics and `/dev/video10` activity. Confirm the result for an actual active stream, not just a loaded device or configured preference.
- Compare the same stream and conditions against the baseline. Report CPU, frame rate and dropped frames, latency, decoder choice, and renderer costs. Hardware decoding must show a measurable CPU improvement or the remaining bottleneck must be explained with measurements.
- Verify at least two concurrent streams, pause/resume, stream closure, reconnection, resolution changes, camera loss/recovery, and decoder exhaustion. Confirm fallback and resource cleanup. Exercise audio and non-H.264 negotiation to detect regressions.
- Confirm macOS and other existing platforms keep their current playback behavior. Validate the eLinux build and deployment on the target Pi. Test Rockchip hardware separately before claiming Rockchip support.

## Scope and follow-up

The first implementation targets decoder integration. Investigate zero-copy texture rendering only after profiling shows that frame conversion or copying remains a material cost. The existing reconnect lifecycle issue should be tracked separately unless it blocks validation of decoder lifecycle.

Background and evidence are in [WEBRTC_HARDWARE_DECODING_REVIEW.md](WEBRTC_HARDWARE_DECODING_REVIEW.md).
