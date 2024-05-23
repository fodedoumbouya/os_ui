import 'package:flutter/material.dart';
import 'package:os_ui/src/os/macOs/windows_management/controller/controller.dart';
// import 'package:os_ui/src/os/macOs/windows_management/model/model.dart';
import 'package:os_ui/src/os/macOs/windows_management/windows/windowsPortal.dart';

class BodyMacOs extends StatelessWidget {
  final Function(bool) onFullScreen;
  final WindowsManagementController windowsManagementController;

  const BodyMacOs(
      {required this.onFullScreen,
      required this.windowsManagementController,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(builder: (context, constraints) {
        final s = constraints.biggest;
        return ValueListenableBuilder(
          valueListenable: windowsManagementController.windows,
          builder: (context, windowsList, child) {
            return Stack(
              children: List.generate(windowsList.length, (index) {
                final windows = windowsList[index];
                return WindowsPortal(
                  safeAreaSize: s,
                  key: Key("$index"),
                  windowsModel: windows,
                  setOnCurrentScreen: (index) {
                    windowsManagementController.swapToCurrentWindow(
                        index: index);
                  },
                  updatePosition: (left, top) {},
                  onFullScreen: (p0) {
                    onFullScreen(p0);
                  },
                  onMinimize: () {
                    windowsManagementController.minimize(index: index);
                  },
                  onClose: () {
                    windowsManagementController.close(index: index);
                  },
                );
              }),
            );
          },
        );
      }),
    );
  }
}
