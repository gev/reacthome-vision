import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class SchemeInteractiveViewer extends StatefulWidget {
  final Widget child;
  final TransformationController transformationController;
  final bool Function(Offset) onSelect;
  final void Function(Offset) onDrag;

  const SchemeInteractiveViewer({
    required this.child,
    required this.transformationController,
    required this.onSelect,
    required this.onDrag,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _SchemeInteractiveViewState();
}

class _SchemeInteractiveViewState extends State<SchemeInteractiveViewer> {
  var panEnabled = true;
  var trackpadScrollCausesScale = false;

  void enablePan(_) {
    setState(() {
      panEnabled = true;
    });
  }

  void disablePan() {
    setState(() {
      panEnabled = false;
    });
  }

  void enableTrackpadScrollCausesScale() {
    setState(() {
      trackpadScrollCausesScale = true;
    });
  }

  void disableTrackpadScrollCausesScale() {
    setState(() {
      trackpadScrollCausesScale = false;
    });
  }

  void onSelect(ScaleStartDetails details) {
    if (details.pointerCount == 1) {
      if (widget.onSelect(
        widget.transformationController.toScene(details.localFocalPoint),
      )) {
        disablePan();
      }
    }
  }

  void onInteract(ScaleUpdateDetails details) {
    if (panEnabled) {
      if (HardwareKeyboard.instance.isAltPressed ||
          HardwareKeyboard.instance.isControlPressed) {
        enableTrackpadScrollCausesScale();
      } else {
        disableTrackpadScrollCausesScale();
      }
    } else {
      widget.onDrag(details.focalPoint);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      boundaryMargin: const EdgeInsets.all(double.infinity),
      minScale: 0.05,
      maxScale: 2.0,
      trackpadScrollCausesScale: trackpadScrollCausesScale,
      panEnabled: panEnabled,
      scaleEnabled: true,
      transformationController: widget.transformationController,
      onInteractionStart: onSelect,
      onInteractionUpdate: onInteract,
      onInteractionEnd: enablePan,
      child: widget.child,
    );
  }
}
