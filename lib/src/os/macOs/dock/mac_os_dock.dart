import 'package:flutter/material.dart';

import '../widgets/animated_tooltip.dart';
import '../../controller/controller.dart';
import '../windows_management/model/model.dart';

class MacOSDock extends StatelessWidget {
  final WindowsManagementController windowsManagementController;

  MacOSDock({super.key, required this.windowsManagementController});

  final hovedIndex = ValueNotifier<int>(-1);

  @override
  Widget build(BuildContext context) {
    final dockStyle = windowsManagementController.dockStyle;
    return ValueListenableBuilder(
        valueListenable: windowsManagementController.windows,
        builder: (context, windowsList, child) {
          List<WindowsModel> appOnBottom = windowsList
              .where((element) =>
                  element.iconPosition == AppIconPosition.dock ||
                  element.iconPosition == AppIconPosition.both ||
                  element.isOpenWindow)
              .toList();
          // sort by index
          appOnBottom.sort((a, b) => a.index.compareTo(b.index));
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 70,
            padding: const EdgeInsets.all(2.0),
            margin: const EdgeInsets.only(
              bottom: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color:
                  dockStyle?.backgroundColor ?? Colors.white.withOpacity(0.3),
            ),
            child: IntrinsicWidth(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    appOnBottom.length,
                    (index) {
                      final app = appOnBottom[index];
                      final imageWidget =
                          switch (app.iconUrl.contains("http")) {
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
                          /// if the app is the launchpad, show the launchpad
                          /// else if the launchpad is open, close it
                          if (app.isLaunchpad ||
                              windowsManagementController
                                  .launchPadToggle.value) {
                            windowsManagementController.showLaunchPadToggle();
                          } else {
                            /// if the app has an onOpen function, call it
                            if (app.onTap != null) {
                              app.onTap!(windowsManagementController);
                              return;
                            }

                            /// if the app is minimized, maximize it
                            /// if the app is open, swap to it
                            /// else add the window
                            if (app.isMinimized) {
                              windowsManagementController.maximize(
                                  index: app.index);
                            } else if (app.isOpenWindow) {
                              windowsManagementController.swapToCurrentWindow(
                                  index: app.index);
                            } else {
                              windowsManagementController.openWindow(app);
                            }
                          }
                        },
                        child: Column(
                          children: [
                            Expanded(
                                child: AnimatedTooltip(
                              content: Text(app.name,
                                  style: dockStyle?.tooltipTextStyle ??
                                      const TextStyle(color: Colors.black)),
                              theme: ThemeData(
                                  canvasColor:
                                      dockStyle?.tooltipBackgroundColor ??
                                          Colors.white.withOpacity(0.8),
                                  shadowColor: Colors.black),
                              onEnter: (p0) {
                                hovedIndex.value = index;
                              },
                              onExit: (p0) {
                                hovedIndex.value = -1;
                              },
                              child: ValueListenableBuilder(
                                valueListenable: hovedIndex,
                                builder: (context, value, child) {
                                  final double y = value == index ? -10 : 0;
                                  final double width = value == index ? 70 : 60;
                                  return AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    height: 60,
                                    width: width,
                                    transform: Matrix4.identity()
                                      ..translate(
                                        0.0,
                                        y,
                                        0.0,
                                      ),
                                    alignment:
                                        AlignmentDirectional.bottomCenter,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 0,
                                    ),
                                    child: imageWidget,
                                  );
                                },
                              ),
                            )),
                            SizedBox(
                              height: 5,
                              width: 5,
                              child: app.isOpenWindow
                                  ? const Icon(
                                      Icons.circle,
                                      size: 4,
                                    )
                                  : const SizedBox.shrink(),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
