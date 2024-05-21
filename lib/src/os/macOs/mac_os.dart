import 'package:flutter/material.dart';
import 'package:os_ui/src/os/macOs/utils/background_frame.dart';
import 'package:os_ui/src/os/macOs/dock/mac_os_dock.dart';

class MacOs extends StatefulWidget {
  const MacOs({super.key});

  @override
  State<MacOs> createState() => _MacOsState();
}

class _MacOsState extends State<MacOs> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return CustomPaint(
      painter: MacOsPainter(
        windowSize: screenSize,
      ),
      child: const Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: MacOSDock(),
          )
        ],
      ),
    );
  }
}
