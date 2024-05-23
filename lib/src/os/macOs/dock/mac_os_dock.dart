import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../widgets/animated_tooltip.dart';
import '../windows_management/controller/controller.dart';
import '../windows_management/model/model.dart';

class MacOSDock extends StatelessWidget {
  final WindowsManagementController windowsManagementController;

  MacOSDock({super.key, required this.windowsManagementController});

  final hovedIndex = ValueNotifier<int>(-1);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: windowsManagementController.windows,
        builder: (context, windowsList, child) {
          final appOnBottom = windowsList
              .where((element) =>
                  element.iconPosition == AppIconPosition.dock ||
                  element.isOpenWindow)
              .toList();
          return Container(
            // alignment: Alignment.bottomCenter,
            // width: 350,
            height: 70,
            padding: const EdgeInsets.all(2.0),
            margin: const EdgeInsets.only(
              bottom: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white.withOpacity(0.3),
            ),
            child: IntrinsicWidth(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    appOnBottom.length,
                    (index) {
                      final app = appOnBottom[index];
                      return Column(
                        children: [
                          Expanded(
                              child: AnimatedTooltip(
                            content: Text("Item $index"),
                            theme: ThemeData(
                                canvasColor: Colors.white.withOpacity(0.8),
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
                                // print(y);
                                return AnimatedContainer(
                                  // color: Colors.red,
                                  duration: const Duration(milliseconds: 200),
                                  height: 60,
                                  width: width,
                                  transform: Matrix4.identity()
                                    ..translate(
                                      0.0,
                                      y,
                                      0.0,
                                    ),
                                  alignment: AlignmentDirectional.bottomCenter,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 0,
                                  ),
                                  child: Image.network(
                                    app.iconUrl,
                                    fit: BoxFit.cover,
                                  ),
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
