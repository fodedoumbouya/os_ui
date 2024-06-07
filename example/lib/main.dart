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
  late WindowsManagementController windowsManagementController;

  @override
  void initState() {
    windowsManagementController = WindowsManagementController(
        launchIconPath: "images/launcher.png",
        appleIconPath: "images/applelogo.png",
        showFlutterText: true,
        applications: [
          WindowsModel(
            name: "Github",
            size: const Size(200, 200),
            iconPosition: AppIconPosition.desktop,
            iconUrl: "images/github.png",
            style: WindowsModelStyle(
              barColor: Colors.blue,
            ),
            onOpen: () {
              windowsManagementController.showToast(
                content: const Text("Toast Content"),
                title: const Text("Toast Title"),
                leading: const Icon(Icons.ac_unit),
              );
            },
          ),
          WindowsModel(
            name: "Github",
            size: const Size(200, 200),
            iconPosition: AppIconPosition.desktop,
            iconUrl: "images/github.png",
            style: WindowsModelStyle(
              barColor: Colors.blue,
            ),
            onOpen: () => print("Github"),
          ),
          WindowsModel(
            name: "Linkedin",
            size: const Size(700, 700),
            iconPosition: AppIconPosition.both,
            // canMinimized: false,
            // canExpand: false,
            iconUrl: "images/linkedin.png",
            style: WindowsModelStyle(
              barColor: Colors.blue,
            ),
            entryApp: (controller) => Container(
              color: Colors.red,
              alignment: Alignment.center,
            ),
          )..isOpenWindow = true,
        ],
        topBarModel: TopBarModel(
          barText: "MacOs",
          popupMenuItemColor: Colors.white,
          listLanguage: [
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
          popupMenuItemsOnAppleIcon: [
            TopBarPopupMenuItem(
              text: "About",
            ),
            TopBarPopupMenuItem(
              text: "Quit",
            )
          ],
        ));

    super.initState();
  }

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
