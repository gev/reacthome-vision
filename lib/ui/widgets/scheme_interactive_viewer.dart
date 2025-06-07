import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class SchemeInteractiveViewer extends StatefulWidget {
  final Widget child;
  final TransformationController transformationController;

  const SchemeInteractiveViewer({
    required this.child,
    required this.transformationController,
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

  void disablePan(_) {
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

  void onInteract(ScaleUpdateDetails details) {
    if (panEnabled) {
      if (HardwareKeyboard.instance.isAltPressed ||
          HardwareKeyboard.instance.isControlPressed) {
        enableTrackpadScrollCausesScale();
      } else {
        disableTrackpadScrollCausesScale();
      }
    } else {
      print(details);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      boundaryMargin: const EdgeInsets.all(double.infinity),
      minScale: 0.5,
      maxScale: 2.0,
      trackpadScrollCausesScale: trackpadScrollCausesScale,
      panEnabled: panEnabled,
      scaleEnabled: true,
      transformationController: widget.transformationController,
      onInteractionUpdate: onInteract,
      onInteractionEnd: enablePan,
      child: panEnabled
          ? GestureDetector(onLongPressDown: disablePan, child: widget.child)
          : widget.child,
    );
  }
}
