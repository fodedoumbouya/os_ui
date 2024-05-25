import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:os_ui/src/os/macOs/windows_management/controller/controller.dart';
import 'package:os_ui/src/os/macOs/windows_management/model/model.dart';
// import 'package:os_ui/src/os/macOs/windows_management/model/model.dart';
import 'package:os_ui/src/os/macOs/windows_management/windows/windowsPortal.dart';

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
                    crossAxisCount: 12,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: deskApp.length,
                  itemBuilder: (context, index) {
                    final app = deskApp[index];
                    return GestureDetector(
                      onTap: () {
                        if (app.isMinimized) {
                          windowsManagementController.maximize(
                              index: app.index);
                        } else if (app.isOpenWindow) {
                          windowsManagementController.swapToCurrentWindow(
                              index: app.index);
                        } else {
                          windowsManagementController.addWindow(app);
                        }
                      },
                      child: Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                app.iconUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Text(
                                app.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
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
                    windows.isCurrentScreen = lastIndex == i;
                    final index = windows.index;
                    // print(
                    //     " currentWindow ${windows.isCurrentScreen} index $index");

                    return WindowsPortal(
                      safeAreaSize: s,
                      key: ValueKey(index),
                      windowsModel: windows,
                      setOnCurrentScreen: (index) {
                        windowsManagementController.swapToCurrentWindow(
                            index: index);
                      },
                      updatePosition: (left, top) {},
                      onFullScreen: (p0) {
                        if (windows.isFullScreen) {
                          windowsManagementController.unFullScreen(
                              index: index);
                        } else {
                          windowsManagementController.fullScreen(index: index);
                        }
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
            ),
          ],
        );
      }),
    );
  }
}
