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

  final WindowsManagementController windowsManagementController =
      WindowsManagementController(
          applications: [
        WindowsModel(
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
            name: "Linkedin",
            size: const Size(700, 700),
            iconPosition: AppIconPosition.dock,
            // canMinimized: false,
            // canExpand: false,
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

  final OsController osController = OsController();
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
          osController: osController,
          osIndentifier: OsIndentifier(
              type: OsType.macos,
              windowsManagementController: windowsManagementController)),
    );
  }
}
