import 'package:flutter/material.dart';
import 'package:os_ui/src/os/macOs/windows_management/windows/windowsPortal.dart';

class BodyMacOs extends StatefulWidget {
  const BodyMacOs({super.key});

  @override
  State<BodyMacOs> createState() => _BodyMacOsState();
}

class _BodyMacOsState extends State<BodyMacOs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(builder: (context, constraints) {
        final s = constraints.biggest;
        return Stack(
          children: List.generate(
              1,
              (index) => WindowsPortal(
                    safeAreaSize: s,
                    key: Key("$index"),
                  )),
        );
      }),
    );
  }
}
