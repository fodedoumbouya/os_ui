import 'package:flutter/material.dart';
import 'package:os_ui/src/os/macOs/bar/bar.dart';
import 'package:os_ui/src/os/macOs/body/body.dart';
import 'package:os_ui/src/os/macOs/utils/background_frame.dart';
import 'package:os_ui/src/os/macOs/dock/mac_os_dock.dart';

import 'windows_management/controller/controller.dart';
import 'windows_management/model/model.dart';

class MacOs extends StatefulWidget {
  const MacOs({super.key});

  @override
  State<MacOs> createState() => _MacOsState();
}

class _MacOsState extends State<MacOs> {
  bool onFullScreen = false;
  final double barHeight = 30;
  static final language = ValueNotifier<String?>("EN");

  final WindowsManagementController windowsManagementController =
      WindowsManagementController(
          applications: [
        WindowsModel(
            index: 0,
            name: "Launcher",
            size: const Size(400, 400),
            iconPosition: AppIconPosition.dock,
            iconUrl:
                "https://cdn.discordapp.com/attachments/1035682064651005972/1242492378154008637/launcher.png?ex=6652a5f3&is=66515473&hm=1d905fb78cfbcd8ef8aacac5035e30f7061dec8b554a868fefa76f7a4feba695&",
            style: WindowsModelStyle(
              barColor: Colors.blue,
            ),
            child: Container(
              color: Colors.blue,
              alignment: Alignment.center,
            )),
        WindowsModel(
            index: 1,
            name: "Launcher",
            size: const Size(200, 200),
            iconPosition: AppIconPosition.desktop,
            iconUrl:
                "https://cdn.discordapp.com/attachments/1035682064651005972/1242492378154008637/launcher.png?ex=6652a5f3&is=66515473&hm=1d905fb78cfbcd8ef8aacac5035e30f7061dec8b554a868fefa76f7a4feba695&",
            style: WindowsModelStyle(
              barColor: Colors.blue,
              // shadowColor: Colors.transparent,
            ),
            child: Container(
              color: Colors.blue,
              alignment: Alignment.center,
            )),
        WindowsModel(
            index: 2,
            name: "Linkedin",
            size: const Size(700, 700),
            iconPosition: AppIconPosition.dock,
            iconUrl:
                "https://cdn.discordapp.com/attachments/1035682064651005972/1243948846871216228/linkedin.png?ex=66535524&is=665203a4&hm=39e9ee28fbbca43addbbb45b376186ec7e1c26ec270c93a0ee064c13ca466ce0&",
            style: WindowsModelStyle(
              barColor: Colors.blue,
              // shadowColor: Colors.transparent,
            ),
            child: Container(
              color: Colors.red,
              alignment: Alignment.center,
            ))
          ..isOpenWindow = true,
      ],
          topBarModel: TopBarModel(
            barText: "MacOs",
            language: language,
            listLanguage: [
              PopupMenuItem(
                child: const Text("EN"),
                onTap: () {
                  language.value = "EN";
                },
              ),
              PopupMenuItem(
                child: const Text("VI"),
                onTap: () {
                  language.value = "VI";
                },
              )
            ],
            popupMenuItemsOnAppleIcon: [
              const PopupMenuItem(
                child: Text("About"),
              ),
              const PopupMenuItem(
                child: Text("Quit"),
              )
            ],
          ));

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
                windowsManagementController: windowsManagementController,
              ),
            ),
          Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(top: onFullScreen ? 0 : barHeight),
                child: BodyMacOs(
                  windowsManagementController: windowsManagementController,
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
                windowsManagementController: windowsManagementController,
              ),
            )
        ],
      ),
    );
  }
}
