import 'package:flutter/material.dart';

import '../drag_triggers_enum.dart';

typedef FunctionCallbackInt = void Function(int b);

class Trigger {
  final Alignment alignment;
  final ({double top, double left})? position;
  final Widget child;
  final double? height;
  final double? width;
  final DragTriggersEnum dragTriggerType;
  final MouseCursor? cursor;

  Trigger({
    this.position,
    this.height,
    this.width,
    this.cursor,
    required this.child,
    required this.dragTriggerType,
    this.alignment = Alignment.center,
  });
}
