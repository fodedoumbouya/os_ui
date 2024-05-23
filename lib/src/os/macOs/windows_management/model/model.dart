import 'package:flutter/material.dart';

class WindowsModel {
  int index;
  Size size;
  Color color;
  // Offset position;
  double? breakPointW;
  bool canExpand;
  bool canMinimized;
  bool isMinimized;
  Widget child;
  String screenName;
  bool visible;
  bool isFullScreen;
  bool isCurrentScreen;
  List<Widget> states;
  WindowsModel(
      {required this.index,
      required this.size,
      required this.color,
      // required this.position,
      this.breakPointW,
      this.canExpand = true,
      this.canMinimized = true,
      this.visible = true,
      this.isFullScreen = false,
      this.isMinimized = false,
      this.isCurrentScreen = true,
      required this.screenName,
      this.states = const [],
      required this.child});

  WindowsModel copyWith({
    int? index,
    Size? size,
    Color? color,
    Offset? position,
    double? breakPointW,
    bool? canExpand,
    bool? canMinimized,
    Widget? child,
    String? screenName,
    bool? visible,
    bool? isMinimized,
    bool? isFullScreen,
    bool? withShadow,
  }) {
    return WindowsModel(
      index: index ?? this.index,
      size: size ?? this.size,
      color: color ?? this.color,
      // position: position ?? this.position,
      breakPointW: breakPointW ?? this.breakPointW,
      canExpand: canExpand ?? this.canExpand,
      canMinimized: canMinimized ?? this.canMinimized,
      child: child ?? this.child,
      screenName: screenName ?? this.screenName,
      visible: visible ?? this.visible,
      isFullScreen: isFullScreen ?? this.isFullScreen,
      isMinimized: isMinimized ?? this.isMinimized,
    );
  }
}
