import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Bar extends StatefulWidget {
  const Bar({super.key});

  @override
  State<Bar> createState() => _BarState();
}

class _BarState extends State<Bar> {
  final double barHeight = 30;
  static const double iconSpace = 10;

  final ValueNotifier<DateTime> _time = ValueNotifier<DateTime>(DateTime.now());
  Timer? timer;
  static List<String> listLanguage = ["EN", "FR"];

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
    // initState();
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
    return Container(
      height: barHeight,
      color: Colors.white.withOpacity(0.3),
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PopupMenuButton(
                onSelected: (value) {
                  // if (value == 0) {
                  //   windowsNotifier.addWidgetToWindows(
                  //       widget:
                  //           myWindows.getAbout(index: getNewIndex()));
                  // } else if (value == 1) {
                  //   unlockControler.setState(newState: true);
                  // }
                },
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
                color: Colors.white.withOpacity(0.5),
                shadowColor: Colors.white.withOpacity(0.5),
                surfaceTintColor: Colors.white.withOpacity(0.5),
                splashRadius: 0,
                constraints: const BoxConstraints(
                  maxWidth: 200,
                ),
                itemBuilder: (BuildContext context) => [
                  const PopupMenuItem(
                    value: 0,
                    child: Text("aboutPc"),
                  ),
                  const PopupMenuItem(
                    value: 1,
                    child: Text("lockScreen"),
                  ),
                ],
                child: Image.network(
                  "https://cdn.discordapp.com/attachments/1035682064651005972/1242796547196850176/applelogo.png?ex=664f23fa&is=664dd27a&hm=a899bc2eb7c42351f9919ed583b535c1cff5a30a17ba80c66e4356815d1441ae&",
                  color: Colors.white,
                  height: 20,
                  width: 20,
                ),
              ),
              const SizedBox(
                width: iconSpace,
              ),
              const Text(
                "fullName",
                style: TextStyle(
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
                    onSelected: (value) {
                      // languageNotifier.changeLanguage(
                      //     language: listLanguage[value]);
                      // rebuildState();
                      // windowsNotifier.removeAllWidget();
                    },
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
                    color: Colors.white.withOpacity(0.5),
                    shadowColor: Colors.white.withOpacity(0.5),
                    surfaceTintColor: Colors.white.withOpacity(0.5),
                    splashRadius: 0,
                    constraints: const BoxConstraints(
                      maxWidth: 100,
                      minWidth: 80,
                    ),
                    itemBuilder: (BuildContext context) => [
                          ...List.generate(listLanguage.length, (index) {
                            return PopupMenuItem(
                              value: index,
                              child: Text(listLanguage[index]),
                            );
                          })
                        ],
                    child: Container(
                      width: 30,
                      height: 20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: const Text(
                        "EN",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                        ),
                      ),
                    )),
                const SizedBox(
                  width: iconSpace,
                ),
                ValueListenableBuilder(
                  valueListenable: _time,
                  builder: (context, value, child) {
                    String formattedTime =
                        DateFormat('E MMM d HH:mm').format(value);
                    return Text(formattedTime,
                        style: const TextStyle(
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
