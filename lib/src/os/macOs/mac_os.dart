import 'package:flutter/material.dart';
import 'package:os_ui/src/os/macOs/utils/background_frame.dart';

class MacOs extends StatefulWidget {
  const MacOs({super.key});

  @override
  State<MacOs> createState() => _MacOsState();
}

class _MacOsState extends State<MacOs> {
  @override
  Widget build(BuildContext context) {
    return //Add this CustomPaint widget to the Widget Tree
        CustomPaint(
      painter: MacOsPainter(
        windowSize: const Size(2145, 1372),
      ),
    );
  }
}
