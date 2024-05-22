import 'package:flutter/material.dart';

class BodyMacOs extends StatefulWidget {
  const BodyMacOs({super.key});

  @override
  State<BodyMacOs> createState() => _BodyMacOsState();
}

class _BodyMacOsState extends State<BodyMacOs> {
  final showActionIcon = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 100,
          left: 100,
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.red,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                )
              ],
            ),
            child: Column(
              children: [
                Container(
                  height: 20,
                  // width: ,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      _widgetAction(),
                    ],
                  ),
                ),

                // Expanded(child: )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _widgetAction() {
    return MouseRegion(
      onEnter: (event) {
        showActionIcon.value = true;
      },
      onExit: (event) {
        showActionIcon.value = false;
      },
      child: Container(
          width: 50,
          margin: const EdgeInsets.only(left: 5),
          alignment: Alignment.center,
          child: ValueListenableBuilder(
            valueListenable: showActionIcon,
            builder: (context, value, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _widgetActionIcon(
                    color: Colors.red,
                    icon: Icons.close,
                    onMouseOn: value,
                  ),
                  _widgetActionIcon(
                    color: Colors.yellow,
                    icon: Icons.minimize,
                    onMouseOn: value,
                    bottomPadding: 3,
                  ),
                  _widgetActionIcon(
                      color: Colors.green,
                      icon: Icons.fullscreen,
                      onMouseOn: value),
                ],
              );
            },
          )),
    );
  }

  Widget _widgetActionIcon({
    required Color color,
    required IconData icon,
    required bool onMouseOn,
    double? bottomPadding = 0,
    double allPadding = 1,
  }) {
    final child = onMouseOn ? Icon(icon) : const SizedBox.shrink();
    final padding = switch (bottomPadding != null) {
      true => EdgeInsets.only(bottom: bottomPadding!),
      false => EdgeInsets.all(allPadding),
    };
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: padding,
      child: FittedBox(child: child),
    );
  }
}
