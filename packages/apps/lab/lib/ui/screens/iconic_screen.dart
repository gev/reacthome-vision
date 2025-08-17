import 'package:flutter/widgets.dart';
import 'package:lab/ui/views/iconic_palette.dart';
import 'package:ui_kit/widgets.dart';

class IconicScreen extends StatefulWidget {
  const IconicScreen({super.key});

  @override
  State<IconicScreen> createState() => _IconicScreenState();
}

class _IconicScreenState extends State<IconicScreen> {
  late bool shouldShowGrid;
  late double size;

  @override
  void initState() {
    super.initState();
    shouldShowGrid = true;
    size = 80;
  }

  void setSize(double value) {
    setState(() {
      size = value;
    });
  }

  void showGrid(bool? value) {
    setState(() {
      shouldShowGrid = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return UI.Scaffold(
      appBar: UI.AppBar(title: 'Iconic experiment'),
      body: Column(
        children: [
          Expanded(
            child: IconicPalette(size: size, shouldShowGrid: shouldShowGrid),
          ),
          UI.Divider(),
          Padding(
            padding: const EdgeInsetsGeometry.all(16),
            child: Row(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Icon size'),
                SizedBox(
                  width: 300,
                  child: UI.Slider(
                    value: size,
                    min: 20,
                    max: 320,
                    onChanged: setSize,
                  ),
                ),
                const Text('Show icon\'s grid'),
                UI.Checkbox(value: shouldShowGrid, onChanged: showGrid),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
