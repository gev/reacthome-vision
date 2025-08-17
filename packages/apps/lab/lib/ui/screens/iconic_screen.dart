import 'package:flutter/widgets.dart';
import 'package:lab/ui/views/iconic_palette.dart';
import 'package:ui_kit/widgets.dart';

class IconicScreen extends StatefulWidget {
  const IconicScreen({super.key});

  @override
  State<IconicScreen> createState() => _IconicScreenState();
}

class _IconicScreenState extends State<IconicScreen> {
  late double size;

  @override
  void initState() {
    super.initState();
    size = 80;
  }

  void setSize(double value) {
    setState(() {
      size = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return UI.Scaffold(
      appBar: UI.AppBar(title: 'Iconic experiment'),
      body: Column(
        children: [
          Expanded(child: IconicPalette(size: size)),
          UI.Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Icon size'),
              Container(
                width: 300,
                padding: const EdgeInsets.all(16),
                child: UI.Slider(
                  value: size,
                  min: 20,
                  max: 320,
                  onChanged: setSize,
                ),
              ),
              const Text('Show icon\'s grid'),
            ],
          ),
        ],
      ),
    );
  }
}
