import 'package:flutter/material.dart';
import 'package:os_ui/src/os/controller/controller.dart';
import 'package:os_ui/src/os/macOs/windows_management/model/model.dart';
// import 'package:os_ui/src/os/macOs/windows_management/model/model.dart';
import 'package:os_ui/src/os/macOs/windows_management/windows/windowsPortal.dart';

import '../launchPad/launchPad.dart';

class BodyMacOs extends StatelessWidget {
  final Function(bool) onFullScreen;

  final WindowsManagementController windowsManagementController;

  const BodyMacOs(
      {required this.onFullScreen,
      required this.windowsManagementController,
      super.key});

  List<WindowsModel> get deskApp => windowsManagementController.windows.value
      .where((element) => element.iconPosition == AppIconPosition.desktop)
      .toList();

  void tapOnApp({required WindowsModel app}) {
    /// if the app has an onOpen function, call it
    if (app.onOpen != null) {
      app.onOpen!();
      return;
    }

    /// on tap on the desktop app icon
    /// if the app is minimized, maximize it
    /// if the app is open window, swap to the current window
    /// else add the window
    if (app.isMinimized) {
      windowsManagementController.maximize(index: app.index);
    } else if (app.isOpenWindow) {
      windowsManagementController.swapToCurrentWindow(index: app.index);
    } else {
      windowsManagementController.openWindow(app);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(builder: (context, constraints) {
        final s = constraints.biggest;
        return Stack(
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 10,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 15,
                  ),
                  itemCount: deskApp.length,
                  itemBuilder: (context, index) {
                    final app = deskApp[index];
                    final imageWidget = switch (app.iconUrl.contains("http")) {
                      true => Image.network(
                          app.iconUrl,
                          fit: BoxFit.cover,
                        ),
                      false => Image.asset(
                          app.iconUrl,
                          fit: BoxFit.cover,
                        ),
                    };
                    return GestureDetector(
                      onTap: () {
                        tapOnApp(app: app);
                      },
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: imageWidget,
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Text(
                                app.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: windowsManagementController
                                        .desktopStyle?.textStyle ??
                                    const TextStyle(
                                      color: Colors.white,
                                    ),
                              ))
                        ],
                      ),
                    );
                  },
                )),
            ValueListenableBuilder(
              valueListenable: windowsManagementController.windows,
              builder: (context, value, child) {
                final windowsList =
                    value.where((element) => element.isOpenWindow).toList();
                return Stack(
                  children: List.generate(windowsList.length, (i) {
                    int lastIndex = windowsList.length - 1;
                    WindowsModel windows = windowsList[i];

                    /// set the current screen to the last index of the window
                    /// because I use the last index to determine the current screen
                    windows.isCurrentScreen = lastIndex == i;

                    /// set the index of the window
                    /// and use it to determine the window
                    final index = windows.index;
                    return WindowsPortal(
                      safeAreaSize: s,
                      controller: windowsManagementController,
                      key: ValueKey(index),
                      windowsModel: windows,
                      setOnCurrentScreen: (index) {
                        /// set the current screen to the index on tap on the window
                        windowsManagementController.swapToCurrentWindow(
                            index: index);
                      },
                      updatePosition: (left, top) {
                        // windows.lastPosition = Offset(left, top);
                        // print(windows.lastPosition);
                      },
                      windowPositionCallback: (windowPosition) {
                        windowsManagementController.updatePosition(
                            window: windows, position: windowPosition);
                        print(windowPosition.toString());
                      },
                      onFullScreen: (p0) {
                        /// on tap on the full screen button
                        /// if the window is in full screen mode, un-full screen it
                        /// else full screen it
                        if (windows.isFullScreen) {
                          windowsManagementController.unFullScreen(
                              index: index);
                        } else {
                          windowsManagementController.fullScreen(index: index);
                        }

                        /// call the onFullScreen function
                        /// to hide the dock and top bar
                        onFullScreen(p0);
                      },
                      onMinimize: () {
                        /// on tap on the minimize button
                        windowsManagementController.minimize(index: index);
                      },
                      onClose: () {
                        if (windows.isFullScreen) {
                          onFullScreen(false);
                        }

                        /// on tap on the close button
                        windowsManagementController.close(index: index);
                      },
                    );
                  }),
                );
              },
            ),
            ValueListenableBuilder(
              valueListenable: windowsManagementController.launchPadToggle,
              builder: (context, value, child) {
                return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    switchInCurve: Curves.easeIn,
                    switchOutCurve: Curves.easeInOut,
                    child: value
                        ? LaunchPad(
                            windowsManagementController:
                                windowsManagementController,
                            onTap: (app) {
                              /// close the launchpad when tap on the app or outside the launchpad
                              windowsManagementController.showLaunchPadToggle();

                              /// if the app is  null, so tap happened outside the launchpad
                              /// if the app is not null, so tap happened on the app
                              if (app != null) {
                                /// call the tapOnApp function
                                tapOnApp(app: app);
                              }
                            },
                          )
                        : const SizedBox.shrink());
              },
            ),
          ],
        );
      }),
    );
  }
}
