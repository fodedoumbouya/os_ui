import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:os_ui/src/os/macOs/bar/bar.dart';
import 'package:os_ui/src/os/macOs/body/body.dart';
import 'package:os_ui/src/os/macOs/utils/background_frame.dart';
import 'package:os_ui/src/os/macOs/dock/mac_os_dock.dart';

import 'windows_management/controller/controller.dart';

class MacOs extends StatefulWidget {
  const MacOs({super.key});

  @override
  State<MacOs> createState() => _MacOsState();
}

class _MacOsState extends State<MacOs> {
  bool onFullScreen = false;
  final double barHeight = 30;

  final WindowsManagementController windowsManagementController =
      WindowsManagementController();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return CustomPaint(
      painter: MacOsPainter(
        windowSize: screenSize,
      ),
      child: Stack(
        children: [
          const Align(
            alignment: Alignment.topCenter,
            child: Bar(),
          ),
          Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(top: barHeight),
                child: BodyMacOs(
                  windowsManagementController: windowsManagementController,
                  onFullScreen: (p0) {
                    onFullScreen = p0;
                    setState(() {});
                  },
                ),
              )),
          if (!onFullScreen)
            Align(
              alignment: Alignment.bottomCenter,
              child: MacOSDock(
                windowsManagementController: windowsManagementController,
              ),
            )
        ],
      ),
    );
  }
}
