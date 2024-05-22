import 'package:flutter/material.dart';

import '../../utils/resizable/drag_triggers_enum.dart';
import '../../utils/resizable/model/trigger.dart';
import '../../utils/resizable/resizable_widget.dart';

class WindowsPortal extends StatefulWidget {
  final Size safeAreaSize;
  const WindowsPortal({super.key, required this.safeAreaSize});

  @override
  State<WindowsPortal> createState() => _WindowsPortalState();
}

class _WindowsPortalState extends State<WindowsPortal> {
  final showActionIcon = ValueNotifier<bool>(false);
  final bool _isFullScreen = false;
  final double barHeight = 30;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: barHeight),
      child: ResizableWidget(
        isCurrentScreen: true,
        isFullScreen: _isFullScreen,
        // initialPosition: const Offset(0, 0),
        index: 0,
        // showDragWidgets: true,
        areaHeight: widget.safeAreaSize.height,
        areaWidth: widget.safeAreaSize.width,
        height: 600,
        width: 600,
        minHeight: 300,
        minWidth: 300,
        dragWidgetsArea: const Size.square(30 / 2),
        onTap: (b) {
          print(b);
        },
        onStartMoving: (b) {
          print(b);
        },
        lastPosition: (p0, p1) {
          print(p0);
          print(p1);
        },
        triggersList: _isFullScreen
            ? []
            : [
                //-----------------------------------------------------------TOP move and resize events--------------------------------------------------------
                Trigger(
                  // position: (left: 0.8, top: 0.0),
                  height: 15,
                  cursor: SystemMouseCursors.resizeUpDown,
                  child: Container(
                    color: Colors.transparent,
                    // height: 10,
                    margin: const EdgeInsets.only(left: 75, right: 15),
                  ),
                  dragTriggerType: DragTriggersEnum.topCenter,
                ),
                Trigger(
                  position: (left: 0.8, top: 0.02),
                  height: 25,
                  cursor: SystemMouseCursors.move,
                  child: Container(
                    color: Colors.transparent,
                    margin: const EdgeInsets.only(left: 75, right: 15),
                  ),
                  dragTriggerType: DragTriggersEnum.center,
                ),
                //--------------------------------------------left move events---------------------------------------------------------------------------------------
                Trigger(
                  position: (left: 0.01, top: 0),
                  cursor: SystemMouseCursors.resizeLeft,
                  child: Container(
                    color: Colors.transparent,
                    width: 10,
                    margin: const EdgeInsets.only(top: 20, bottom: 20),
                  ),
                  dragTriggerType: DragTriggersEnum.centerLeft,
                ),
                //--------------------------------------------right move events---------------------------------------------------------------------------------------
                Trigger(
                  // position: (left: 0.0, top: 0),
                  // height: 100,
                  cursor: SystemMouseCursors.resizeRight,
                  child: Container(
                    color: Colors.transparent,
                    width: 10,
                    margin:
                        const EdgeInsets.only(top: 20, bottom: 20, right: 10),
                  ),
                  dragTriggerType: DragTriggersEnum.centerRight,
                ),
                //--------------------------------------------Bottom move events---------------------------------------------------------------------------------------
                Trigger(
                  // position: (left: 0.0, top: 0),
                  // height: 100,
                  cursor: SystemMouseCursors.resizeUpDown,
                  child: Container(
                    color: Colors.transparent,
                    height: 10,
                    margin:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  ),
                  dragTriggerType: DragTriggersEnum.bottomCenter,
                ),
                //--------------------------------------------left bottom center  move events---------------------------------------------------------------------------------------
                Trigger(
                  // position: (left: 0.0, top: 0),
                  // height: 100,
                  cursor: SystemMouseCursors.resizeUpRightDownLeft,
                  child: Container(
                    color: Colors.transparent,
                    margin: const EdgeInsets.only(left: 5, bottom: 10),
                    // rightM: 10,
                    // w: 10,
                    height: 15,
                    width: 15,
                  ),
                  dragTriggerType: DragTriggersEnum.bottomLeft,
                ),
                //--------------------------------------------Right bottom center  move events---------------------------------------------------------------------------------------
                Trigger(
                  // position: (left: 0.0, top: 0),
                  // height: 100,
                  cursor: SystemMouseCursors.resizeUpLeftDownRight,
                  child: Container(
                    margin: const EdgeInsets.only(right: 5, bottom: 10),
                    color: Colors.transparent,
                    height: 15,
                    width: 15,
                  ),
                  dragTriggerType: DragTriggersEnum.bottomRight,
                ),
                //--------------------------------------------TOP  Rigtht  move events---------------------------------------------------------------------------------------
                Trigger(
                  // position: (left: 0.0, top: 0),
                  // height: 100,
                  cursor: SystemMouseCursors.resizeUpRightDownLeft,
                  child: Container(
                    // topM: 10,
                    // rightM: 10,
                    margin: const EdgeInsets.only(top: 10, right: 5),
                    color: Colors.transparent,
                    height: 15,
                    width: 15,
                  ),
                  dragTriggerType: DragTriggersEnum.topRight,
                ),
                //--------------------------------------------TOP left  move events---------------------------------------------------------------------------------------
                Trigger(
                  // position: (left: 0.0, top: 0),
                  // height: 100,
                  cursor: SystemMouseCursors.resizeUpLeftDownRight,
                  child: Container(
                    // topM: 10,
                    // leftM: 10,
                    margin: const EdgeInsets.only(top: 10, left: 5),
                    // rightM: 10,
                    // w: 10,
                    // color: Colors.amber,
                    height: 15,
                    width: 15,
                  ),
                  dragTriggerType: DragTriggersEnum.topLeft,
                ),
              ],
        child: Container(
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
                alignment: Alignment.centerLeft,
                child: _widgetAction(),
              ),

              // Expanded(child: )
            ],
          ),
        ),
      ),
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
                    onMouseOn: value,
                    onTap: () {},
                  ),
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
    void Function()? onTap,
  }) {
    final child = onMouseOn ? Icon(icon) : const SizedBox.shrink();
    final padding = switch (bottomPadding != null) {
      true => EdgeInsets.only(bottom: bottomPadding!),
      false => EdgeInsets.all(allPadding),
    };
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
        ),
        padding: padding,
        child: FittedBox(child: child),
      ),
    );
  }
}
