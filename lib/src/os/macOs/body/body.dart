import 'package:flutter/material.dart';
import 'package:os_ui/src/os/macOs/windows_management/controller/controller.dart';
// import 'package:os_ui/src/os/macOs/windows_management/model/model.dart';
import 'package:os_ui/src/os/macOs/windows_management/windows/windowsPortal.dart';

class BodyMacOs extends StatefulWidget {
  final Function(bool) onFullScreen;

  const BodyMacOs({required this.onFullScreen, super.key});

  @override
  State<BodyMacOs> createState() => _BodyMacOsState();
}

class _BodyMacOsState extends State<BodyMacOs> {
  bool onFullScreen = false;
  final WindowsManagementController windowsManagementController =
      WindowsManagementController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(builder: (context, constraints) {
        final s = constraints.biggest;
        return Stack(
          children: List.generate(windowsManagementController.windows.length,
              (index) {
            final windows = windowsManagementController.windows[index];

            return WindowsPortal(
              safeAreaSize: s,
              key: Key("$index"),
              windowsModel: windows,
              setOnCurrentScreen: (index) {
                windowsManagementController.swapToCurrentWindow(index: index);
              },
              updatePosition: (left, top) {
                // print("updatePosition");
              },
              onFullScreen: (p0) {
                widget.onFullScreen(p0);
              },
            );
          }),
        );
      }),
    );
  }
}
