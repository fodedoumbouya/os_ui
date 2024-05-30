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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
            // child: Container(
            //   color: Colors.blue,
            //   alignment: Alignment.center,
            // ),
            onOpen: () {
              windowsManagementController.showToast(
                content: const Text("Github"),
                title: const Text("Github"),
                leading: const Icon(Icons.ac_unit),
              );
            },
            // => print("Github"),
          ),
          WindowsModel(
            name: "Github",
            size: const Size(200, 200),
            iconPosition: AppIconPosition.desktop,
            iconUrl: "images/github.png",
            style: WindowsModelStyle(
              barColor: Colors.blue,
              // shadowColor: Colors.transparent,
            ),
            // child: Container(
            //   color: Colors.blue,
            //   alignment: Alignment.center,
            // ),
            onOpen: () => print("Github"),
          ),
          WindowsModel(
              name: "Linkedin",
              size: const Size(700, 700),
              iconPosition: AppIconPosition.dock,
              // canMinimized: false,
              // canExpand: false,
              iconUrl: "images/linkedin.png",
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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Os(
          osIndentifier: OsIndentifier(
              type: OsType.macos,
              windowsManagementController: windowsManagementController)),
    );
  }
}
