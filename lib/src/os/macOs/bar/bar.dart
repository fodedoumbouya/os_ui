import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:os_ui/os_ui.dart';


class Bar extends StatefulWidget {
  final WindowsManagementController windowsManagementController;

  const Bar({super.key, required this.windowsManagementController});

  @override
  State<Bar> createState() => _BarState();
}

class _BarState extends State<Bar> {
  final double barHeight = 30;
  static const double iconSpace = 10;

  final ValueNotifier<DateTime> _time = ValueNotifier<DateTime>(DateTime.now());
  Timer? timer;

  initTme() {
    // Update the time every second
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _time.value = DateTime.now();
      if (!mounted) {
        timer.cancel();
      }
    });
  }

  @override
  void initState() {
    initTme();
    super.initState();
  }

  @override
  void dispose() {
    _time.dispose();
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }

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
      widget.windowsManagementController.maximize(index: app.index);
    } else if (app.isOpenWindow) {
      widget.windowsManagementController.swapToCurrentWindow(index: app.index);
    } else {
      widget.windowsManagementController.openWindow(app);
    }
  }

  @override
  Widget build(BuildContext context) {
    final topBarModel = widget.windowsManagementController.topBarModel;
    final language = topBarModel?.language ?? ValueNotifier<String?>(null);
    final iconUrl = widget.windowsManagementController.appleIconPath;
    final imageWidget = switch (iconUrl.contains("http")) {
      true => Image.network(
          iconUrl,
          fit: BoxFit.cover,
          color: topBarModel?.iconColor ?? Colors.white,
          height: 20,
          width: 20,
        ),
      false => Image.asset(
          iconUrl,
          fit: BoxFit.cover,
          color: topBarModel?.iconColor ?? Colors.white,
          height: 20,
          width: 20,
        ),
    };

    return Container(
      height: barHeight,
      color: topBarModel?.backgroundColor ?? Colors.white.withOpacity(0.3),
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PopupMenuButton(
                offset: Offset(0, barHeight),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                ),
                padding: const EdgeInsets.all(8.0),
                tooltip: "",
                color: topBarModel?.popupMenuItemColor ??
                    Colors.white.withOpacity(0.8),
                shadowColor: topBarModel?.popupMenuItemShadowColor ??
                    Colors.white.withOpacity(0.5),
                surfaceTintColor: topBarModel?.popupMenuItemSurfaceTintColor ??
                    Colors.white.withOpacity(0.5),
                splashRadius: 0,
                constraints: const BoxConstraints(
                  maxWidth: 200,
                ),
                itemBuilder: (BuildContext context) => [
                  ...List.generate(
                      (topBarModel?.popupMenuItemsOnAppleIcon ?? []).length,
                      (index) {
                    final item = topBarModel!.popupMenuItemsOnAppleIcon[index];
                    return PopupMenuItem(
                      onTap: () {
                        if (item.entryApp != null) {
                          tapOnApp(app: item.entryApp!);
                        }
                      },
                      padding: item.padding,
                      child: item.builder(widget.windowsManagementController),
                    );
                    // item;
                  })
                ],
                child: imageWidget,
              ),
              const SizedBox(
                width: iconSpace,
              ),
              Text(
                topBarModel?.barText ?? "",
                style: topBarModel?.textStyle ??
                    const TextStyle(
                      color: Colors.white,
                    ),
              ),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PopupMenuButton(
                    offset: Offset(30, barHeight),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                      ),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    tooltip: "",
                    color: topBarModel?.popupMenuItemColor ??
                        Colors.white.withOpacity(0.5),
                    shadowColor: topBarModel?.popupMenuItemShadowColor ??
                        Colors.white.withOpacity(0.5),
                    surfaceTintColor:
                        topBarModel?.popupMenuItemSurfaceTintColor ??
                            Colors.white.withOpacity(0.5),
                    splashRadius: 0,
                    constraints: const BoxConstraints(
                      maxWidth: 100,
                      minWidth: 80,
                    ),
                    itemBuilder: (BuildContext context) => [
                          ...List.generate(
                              (topBarModel?.listLanguage ?? []).length,
                              (index) {
                            final item = topBarModel!.listLanguage[index];
                            return PopupMenuItem(
                              onTap: () {
                                if (item.entryApp != null) {
                                  tapOnApp(app: item.entryApp!);
                                }
                              },
                              padding: item.padding,
                              child: item
                                  .builder(widget.windowsManagementController),
                            );
                          })
                        ],
                    child: ValueListenableBuilder(
                      valueListenable: language,
                      builder: (context, value, child) {
                        return value == null
                            ? const SizedBox.shrink()
                            : Container(
                                width: 30,
                                height: 20,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: Text(
                                  value,
                                  textAlign: TextAlign.center,
                                  style: topBarModel?.textStyle ??
                                      const TextStyle(
                                        color: Colors.black87,
                                      ),
                                ),
                              );
                      },
                    )),
                const SizedBox(
                  width: iconSpace,
                ),
                ValueListenableBuilder(
                  valueListenable: _time,
                  builder: (context, value, child) {
                    String formattedTime =
                        (topBarModel?.dateFormat ?? DateFormat('E MMM d HH:mm'))
                            .format(value);
                    return Text(formattedTime,
                        style: topBarModel?.textStyle ??
                            const TextStyle(
                              color: Colors.white,
                            ));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
