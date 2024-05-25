import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../windows_management/controller/controller.dart';

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

  @override
  Widget build(BuildContext context) {
    final topBarModel = widget.windowsManagementController.topBarModel;
    final language = topBarModel?.language ?? ValueNotifier<String?>(null);
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
                    return item;
                  })
                ],
                child: Image.network(
                  "https://cdn.discordapp.com/attachments/1035682064651005972/1242796547196850176/applelogo.png?ex=6653187a&is=6651c6fa&hm=42eaf858fda6c638fc6a96f804c296a7009adc154fedf9fb85aa5c2312eb5ada&",
                  color: topBarModel?.iconColor ?? Colors.white,
                  height: 20,
                  width: 20,
                ),
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
                            return item;
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
