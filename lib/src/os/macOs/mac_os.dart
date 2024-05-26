import 'package:flutter/material.dart';
import 'package:os_ui/src/os/macOs/bar/bar.dart';
import 'package:os_ui/src/os/macOs/body/body.dart';
import 'package:os_ui/src/os/macOs/launchPad/launchPad.dart';
import 'package:os_ui/src/os/macOs/utils/background_frame.dart';
import 'package:os_ui/src/os/macOs/dock/mac_os_dock.dart';

import 'utils/constant.dart';
import 'windows_management/controller/controller.dart';

class MacOs extends StatefulWidget {
  final WindowsManagementController windowsManagementController;
  const MacOs({super.key, required this.windowsManagementController});

  @override
  State<MacOs> createState() => _MacOsState();
}

class _MacOsState extends State<MacOs> {
  bool onFullScreen = false;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return CustomPaint(
      painter: MacOsPainter(
        windowSize: screenSize,
      ),
      child: Stack(
        children: [
          if (!onFullScreen)
            Align(
              alignment: Alignment.topCenter,
              child: Bar(
                windowsManagementController: widget.windowsManagementController,
              ),
            ),
          Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(top: onFullScreen ? 0 : barHeight),
                child: BodyMacOs(
                  windowsManagementController:
                      widget.windowsManagementController,
                  onFullScreen: (p0) {
                    onFullScreen = p0;
                    if (mounted) {
                      setState(() {});
                    }
                  },
                ),
              )),
          if (!onFullScreen)
            Align(
              alignment: Alignment.bottomCenter,
              child: MacOSDock(
                windowsManagementController: widget.windowsManagementController,
              ),
            )
        ],
      ),
    );
  }
}
