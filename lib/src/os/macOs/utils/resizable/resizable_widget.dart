import 'package:flutter/material.dart';
import 'package:os_ui/os_ui.dart';
import 'package:os_ui/src/os/macOs/utils/resizable/drag_triggers_enum.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'model/common_sizes.dart';
import 'model/trigger.dart';
import 'resizable_widget_controller.dart';
import 'trigger_widget.dart';

class ResizableWidget extends StatefulWidget {
  ResizableWidget(
      {super.key,
      double? height,
      double? width,
      Offset? initialPosition,
      double minWidth = 0.0,
      double minHeight = 0.0,
      this.enableDragWidgets,
      this.isFullScreen = false,
      this.index,
      required this.isCurrentScreen,
      required double areaHeight,
      required double areaWidth,
      required this.child,
      required this.dragWidgetsArea,
      required this.triggersList,
      required this.onTap,
      required this.onStartMoving,
      this.initWindowPosition,
      this.windowPositionCallback,
      required this.lastPosition}) {
    height ??= areaHeight;
    width ??= areaWidth;

    initialPosition ??= Offset(areaWidth / 2, areaHeight / 2);
    size = CommonSizes(
      areaHeight: areaHeight,
      areaWidth: areaWidth,
      height: height,
      width: width,
      minHeight: minHeight,
      minWidth: minWidth,
      initialPosition: initialPosition,
    );
  }
  late final CommonSizes size;
  final bool? enableDragWidgets;
  final Widget child;
  final Size dragWidgetsArea;
  final List<Trigger> triggersList;
  final FunctionCallbackInt onTap;
  final FunctionCallbackInt onStartMoving;

  final void Function(double, double) lastPosition;
  final WindowPosition? initWindowPosition;
  final void Function(WindowPosition windowPosition)? windowPositionCallback;

  bool isFullScreen;
  final int? index;
  final bool isCurrentScreen;

  @override
  State<ResizableWidget> createState() => _ResizableWidgetState();
}

class _ResizableWidgetState extends State<ResizableWidget> {
  late final ResizableWidgetController controller;

  // late double oldHeight;
  // late double oldWidth;
  late CommonSizes oldSize;

  @override
  void initState() {
    controller = ResizableWidgetController();
    controller.init(
        finalSize: widget.size,
        showDragWidgets: widget.enableDragWidgets,
        windowPosition: widget.initWindowPosition);
    oldSize = widget.size;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ResizableWidget oldWidget) {
    if (widget.isFullScreen != oldWidget.isFullScreen) {
      if (widget.isFullScreen) {
        controller.setSize(
          newLeft: widget.size.areaWidth / widget.size.width,
          newRight: widget.size.areaWidth / widget.size.width,
          newTop: widget.size.areaHeight / widget.size.height,
          newBottom: widget.size.areaHeight / widget.size.height,
        );
      } else {
        double newTop = oldSize.initialPosition.dy - oldSize.height / 2;
        double newBottom = oldSize.areaHeight - oldSize.height - newTop;
        double newLeft = oldSize.initialPosition.dx - (oldSize.width / 2);
        double newRight = (oldSize.areaWidth - oldSize.width) - newLeft;
        controller.setSize(
            newBottom: newBottom,
            newTop: newTop,
            newLeft: newLeft,
            newRight: newRight);
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      child: Stack(
        children: widget.triggersList.map((trigger) {
          if (widget.enableDragWidgets == false &&
              trigger.cursor != SystemMouseCursors.move) {
            return const SizedBox.shrink();
          }
          return TriggerWidget(
            onDrag: trigger.dragTriggerType.getOnDragFunction(controller),
            trigger: trigger,
            onTap: widget.onStartMoving,
            lastPosition: widget.lastPosition,
            index: widget.index,
          );
        }).toList(),
      ),
      builder: (_, triggersStack) {
        widget.windowPositionCallback?.call(WindowPosition(
          newTop: controller.top,
          newLeft: controller.left,
          newRight: controller.right,
          newBottom: controller.bottom,
        ));

        return Stack(
          children: <Widget>[
            Positioned(
              top: controller.top,
              left: controller.left,
              bottom: controller.bottom,
              right: controller.right,
              child: widget.child,
            ),
            Positioned(
                top: controller.top - widget.dragWidgetsArea.height,
                left: controller.left - widget.dragWidgetsArea.width,
                bottom: controller.bottom - widget.dragWidgetsArea.height,
                right: controller.right - widget.dragWidgetsArea.width,
                child: triggersStack!

                //  Visibility(
                //   visible: controller.showDragWidgets,
                //   child: triggersStack!,
                // ),
                ),

            Positioned(
              top: controller.top,
              left: controller.left,
              bottom: controller.bottom,
              right: controller.right,
              child: !widget.isCurrentScreen
                  ? PointerInterceptor(
                      child: Container(
                        color: Colors.transparent,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),

            Positioned(
              top: controller.top,
              left: controller.left,
              bottom: controller.bottom,
              right: controller.right,
              child: !widget.isCurrentScreen
                  ? Listener(
                      onPointerDown: (event) {
                        widget.onTap(widget.index ?? -1);
                      },
                      child: Container(
                        color: Colors.transparent,
                      ),
                    )
                  : const SizedBox.shrink(),
            )

            // Positioned(
            //   top: controller.top,
            //   left: controller.left,
            //   bottom: controller.bottom,
            //   right: controller.right,
            //   child: Visibility(
            //     visible: widget.isFullScreen,
            //     child: Container(
            //       height: widget.size.areaWidth,
            //       width: widget.size.width,
            //       alignment: Alignment.center,
            //       child: widget.child,
            //     ),
            //   ),
            // ),
          ],
        );
      },
    );
  }
}
