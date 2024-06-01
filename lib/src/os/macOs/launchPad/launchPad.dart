import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:os_ui/os_ui.dart';
import 'package:os_ui/src/os/macOs/utils/background_frame.dart';
import 'package:os_ui/src/os/macOs/utils/constant.dart';

import '../../controller/controller.dart';

class LaunchPad extends StatelessWidget {
  final WindowsManagementController windowsManagementController;
  final Function(WindowsModel?) onTap;

  const LaunchPad(
      {super.key,
      required this.windowsManagementController,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final apps = windowsManagementController.windows.value
        .where((element) =>
            !element.isLaunchpad &&
            element.iconPosition != AppIconPosition.none)
        .toList();
    return CustomPaint(
      painter: MacOsPainter(
        windowSize: screenSize,
      ),
      child: GestureDetector(
        onTap: () {
          onTap(null);
        },
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: barHeight,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                child: Container(
                  decoration: BoxDecoration(color: Colors.red.withOpacity(0.2)),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: screenSize.width * 0.15,
                top: 100,
                right: screenSize.width * 0.15,
                bottom: 100,
              ),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: screenSize.width > 700 ? 8 : 5),
                itemCount: apps.length,
                itemBuilder: (context, index) {
                  final app = apps[index];
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
                      /// on tap on the desktop app icon return the app
                      onTap(app);
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
