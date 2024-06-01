import 'package:flutter/material.dart';
import 'package:os_ui/src/os/macOs/bar/bar.dart';
import 'package:os_ui/src/os/macOs/body/body.dart';
import 'package:os_ui/src/os/macOs/utils/background_frame.dart';
import 'package:os_ui/src/os/macOs/dock/mac_os_dock.dart';

import 'utils/constant.dart';
import '../controller/controller.dart';

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
            ),
          ValueListenableBuilder(
            valueListenable: widget.windowsManagementController.toast.showToast,
            builder: (context, dialogOpen, child) {
              return AnimatedPositioned(
                  top: dialogOpen ? 10 : -200,
                  // left: 0,
                  right: 0,
                  width: 350,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                      // height: 150,
                      margin: widget.windowsManagementController.toast
                              .contentPadding ??
                          const EdgeInsets.all(30),
                      padding: const EdgeInsets.all(20),
                      decoration: widget.windowsManagementController.toast
                              .toastDecoration ??
                          BoxDecoration(
                            color: const Color.fromARGB(255, 228, 227, 224),
                            borderRadius: BorderRadius.circular(30),
                          ),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: widget.windowsManagementController.toast
                                      .leading ??
                                  const SizedBox.shrink()),
                          Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  widget.windowsManagementController.toast
                                          .title ??
                                      const SizedBox.shrink(),
                                  widget.windowsManagementController.toast
                                          .content ??
                                      const SizedBox.shrink(),
                                ],
                              )),
                          widget.windowsManagementController.toast.trailing ??
                              const SizedBox.shrink(),
                        ],
                      )

                      // ListTile(
                      //   titleAlignment: ListTileTitleAlignment.center,
                      //   contentPadding: widget
                      //       .windowsManagementController.toast.contentPadding,
                      //   leading: widget.windowsManagementController.toast.leading,
                      //   title: widget.windowsManagementController.toast.title,
                      //   subtitle:
                      //       widget.windowsManagementController.toast.content,
                      //   trailing:
                      //       widget.windowsManagementController.toast.trailing,
                      // ),
                      ));
            },
          )
        ],
      ),
    );
  }
}
