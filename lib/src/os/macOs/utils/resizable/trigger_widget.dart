import 'package:flutter/material.dart';
import 'drag_triggers_enum.dart';
import 'model/trigger.dart';

class TriggerWidget extends StatefulWidget {
  final DragDetailsCallback onDrag;
  final Trigger trigger;
  final FunctionCallbackInt onTap;
  // final void Function(double, double) lastPosition;
  final double initX;
  final double initY;
  final int? index;

  const TriggerWidget({
    super.key,
    required this.onDrag,
    required this.trigger,
    required this.onTap,
    // required this.lastPosition,
    this.initX = 0.0,
    this.initY = 0.0,
    this.index,
  });

  @override
  State<StatefulWidget> createState() {
    return _TriggerWidgetState();
  }
}

class _TriggerWidgetState extends State<TriggerWidget> {
  double initX = 0;
  double initY = 0;

  void _handleDrag(DragStartDetails details) {
    widget.onTap(widget.index ?? -1);
    //.call(widget.index ?? -1);
    initX = details.globalPosition.dx;
    initY = details.globalPosition.dy;
  }

  void _handleUpdate(DragUpdateDetails details) {
    final double dx = details.globalPosition.dx - initX;
    final double dy = details.globalPosition.dy - initY;
    initX = details.globalPosition.dx;
    initY = details.globalPosition.dy;

    widget.onDrag(dx, dy);
  }

  @override
  Widget build(BuildContext context) {
    ({double left, double top})? p = widget.trigger.position;
    return MouseRegion(
      cursor: widget.trigger.cursor ?? MouseCursor.defer,
      hitTestBehavior: HitTestBehavior.deferToChild,
      child: Align(
        // alignment: widget.trigger.alignment,
        alignment: p == null
            ? widget.trigger.dragTriggerType.alignment
            : FractionalOffset(p.left, p.top),
        // top: p.top,
        // left: p.left,
        child: SizedBox(
          width: widget.trigger.width,
          height: widget.trigger.height,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            // onTap: widget.onTap.call(widget.index ?? -1),
            onPanStart: _handleDrag,
            onPanUpdate: _handleUpdate,
            // onTapDown: (details) {
            //   print("index: ${widget.index}");
            //   widget.onTap(widget.index ?? -1);

            //   // widget.lastPosition(initX, initY);
            // },
            // onPanEnd: (details) {
            //   widget.lastPosition(initX, initY);
            // },
            child: widget.trigger.child,
          ),
        ),
      ),
    );
  }
}
