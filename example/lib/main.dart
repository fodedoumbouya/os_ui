import 'package:flutter/material.dart';
import 'package:os_ui/os_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WindowsManagementController windowsManagementController =
      WindowsManagementController(

          /// path to the launcher icon
          // launchIconPath: "images/launcher.png",

          /// path to the apple icon
          // appleIconPath: "images/applelogo.png",

          /// show the flutter text
          showFlutterText: true,

          /// list of applications to be displayed on the macOs
          applications: [
            WindowsModel(
              /// name of the application
              name: "Toast",

              /// size of the application window if you decide to just show the icon and not display the window on tap on the icon
              /// set the size to Size.zero
              /// if you want to display the window on tap on the icon, set the size to the size of the window
              /// and user can minimize, maximize, and expand the window
              /// if you don't want the user to minimize, maximize, and expand the window, set [canMinimized],[canExpand] to false
              size: Size.zero,

              /// position of the icon on the os
              /// [AppIconPosition.desktop] to display the icon on the desktop
              /// [AppIconPosition.dock] to display the icon on the dock
              /// [AppIconPosition.both] to display the icon on the desktop and dock
              iconPosition: AppIconPosition.desktop,

              /// url of the icon
              /// you can use a network image or local image
              iconUrl: "images/alert.png",

              /// style of the application window
              style: WindowsModelStyle(
                barColor: Colors.blue,
              ),

              /// [onTap] function to be called on tap on the icon and the window is not displayed
              /// if you want to display the window on tap on the icon, set the [entryApp] function
              onTap: (controller) {
                /// on tap on the  app icon
                /// show a toast
                controller.showToast(
                  content: const Text("Toast Content"),
                  title: const Text("Toast Title"),
                  leading: const Icon(Icons.ac_unit),
                );
              },
            ),
            WindowsModel(
              name: "Dart",
              size: const Size(700, 700),
              iconPosition: AppIconPosition.desktop,
              iconUrl: "images/dart.png",
              style: WindowsModelStyle(
                barColor: Colors.blue,
              ),

              /// [entryApp] function to be called on tap on the icon and the window is displayed
              entryApp: (controller) {
                return Screen1(controller: controller);
              },
            ),
            WindowsModel(
              name: "Flutter",
              size: const Size(700, 700),
              iconPosition: AppIconPosition.both,
              canMinimized: false,
              canExpand: false,
              iconUrl: "images/flutter.png",
              style: WindowsModelStyle(
                barColor: Colors.blue,
              ),
              entryApp: (controller) => Container(
                color: Colors.red,
                alignment: Alignment.center,
                child: const Text("Flutter",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],

          /// top bar model for the macOs
          topBarModel: TopBarModel(
            // barText: "MacOs",
            // popupMenuItemColor: Colors.white,

            /// popup menu items on the list language
            listLanguages: [
              TopBarPopupMenuItem(
                text: "EN",
                onTap: () {
                  print("EN");
                },
              ),
              TopBarPopupMenuItem(
                text: "FR",
                onTap: () {
                  print("FR");
                },
              )
            ],

            /// popup menu items on the apple icon
            popupMenuItemsOnAppleIcon: [
              TopBarPopupMenuItem(
                text: "About",
              ),
              TopBarPopupMenuItem(
                text: "Quit",
              )
            ],
          ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Os(
          osIndentifier: OsIndentifier(
              type: OsType.macos,
              windowsManagementController: windowsManagementController)),
    );
  }
}

/// Screen 1 for test navigation
class Screen1 extends StatelessWidget {
  final WindowsManagementController controller;
  const Screen1({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Screen 1"),
          ElevatedButton(
            onPressed: () {
              controller.goTo(
                entryApp: (controller) {
                  return Screen2(controller: controller);
                },
              );
            },
            child: const Text("Go to Screen 2"),
          ),
        ],
      ),
    );
  }
}

/// Screen 2 for test navigation
class Screen2 extends StatelessWidget {
  final WindowsManagementController controller;
  const Screen2({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Screen 2", style: TextStyle(color: Colors.white)),
              ElevatedButton(
                onPressed: () {
                  controller.goBack();
                },
                child: const Text("Go back to Screen 1"),
              ),
            ],
          ),
        ));
  }
}
