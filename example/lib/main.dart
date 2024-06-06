import 'package:flutter/material.dart';
import 'package:os_ui/os_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  static final language = ValueNotifier<String?>("EN");
  late WindowsManagementController windowsManagementController;

  @override
  void initState() {
    windowsManagementController = WindowsManagementController(
        launchIconPath: "images/launcher.png",
        appleIconPath: "images/applelogo.png",
        applications: [
          WindowsModel(
            name: "Github",
            size: const Size(200, 200),
            iconPosition: AppIconPosition.desktop,
            iconUrl: "images/github.png",
            style: WindowsModelStyle(
              barColor: Colors.blue,
              // shadowColor: Colors.transparent,
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
          language: language,
          listLanguage: [
            TopBarPopupMenuItem(
              builder: (controller) => const Text("EN"),
            ),
            TopBarPopupMenuItem(
              builder: (controller) => const Text("FR"),
              // entryApp: WindowsModel(
              //     size: Size.zero, name: "name", iconUrl: "iconUrl"),
              // onTap: () {},
            )
          ],
          popupMenuItemsOnAppleIcon: [
            TopBarPopupMenuItem(
              builder: (controller) => const Text("About"),
            ),
            TopBarPopupMenuItem(
              builder: (controller) => const Text("Quit"),
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
