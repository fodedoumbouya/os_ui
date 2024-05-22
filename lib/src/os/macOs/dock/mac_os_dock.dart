import 'package:flutter/material.dart';

import '../widgets/animated_tooltip.dart';

class MacOSDock extends StatefulWidget {
  const MacOSDock({super.key});

  @override
  State<MacOSDock> createState() => _MacOSDockState();
}

class _MacOSDockState extends State<MacOSDock> {
  final hovedIndex = ValueNotifier<int>(-1);

  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: Alignment.bottomCenter,
      // width: 350,
      // height: 60,
      padding: const EdgeInsets.all(2.0),
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(0.3),
      ),
      child: IntrinsicWidth(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(
              6,
              (index) {
                return AnimatedTooltip(
                    content: Text("Item $index"),
                    theme: ThemeData(
                        canvasColor: Colors.white.withOpacity(0.8),
                        shadowColor: Colors.black),
                    onEnter: (p0) {
                      hovedIndex.value = index;
                    },
                    onExit: (p0) {
                      hovedIndex.value = -1;
                    },
                    child: ValueListenableBuilder(
                      valueListenable: hovedIndex,
                      builder: (context, value, child) {
                        final double y = value == index ? -10 : 0;
                        final double width = value == index ? 70 : 60;
                        // print(y);
                        return AnimatedContainer(
                          // color: Colors.red,
                          duration: const Duration(milliseconds: 200),
                          height: 60,
                          width: width,
                          transform: Matrix4.identity()
                            ..translate(
                              0.0,
                              y,
                              0.0,
                            ),
                          alignment: AlignmentDirectional.bottomCenter,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 0,
                          ),
                          child: Image.network(
                            "https://cdn.discordapp.com/attachments/1035682064651005972/1242492378154008637/launcher.png?ex=664e08b3&is=664cb733&hm=ff8c68f9cf18babb1c118f06dd10974862314315f9655b61f8a4af9264f073f8&",
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
