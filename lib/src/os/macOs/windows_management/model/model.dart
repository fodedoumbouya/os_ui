import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WindowsModelStyle {
  final Color? barColor;
  final Color? shadowColor;

  WindowsModelStyle({this.barColor, this.shadowColor});
}

class TopBarModel {
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final Color? iconColor;
  final String? barText;
  final Function? onAbout;
  final List<PopupMenuItem> popupMenuItemsOnAppleIcon;
  final Color? popupMenuItemColor;
  final Color? popupMenuItemShadowColor;
  final Color? popupMenuItemSurfaceTintColor;
  final ValueNotifier<String?>? language;
  final List<PopupMenuItem> listLanguage;
  final DateFormat? dateFormat;
  TopBarModel(
      {this.backgroundColor,
      this.textStyle,
      this.iconColor,
      this.barText,
      this.onAbout,
      this.popupMenuItemsOnAppleIcon = const [],
      this.popupMenuItemColor,
      this.popupMenuItemShadowColor,
      this.popupMenuItemSurfaceTintColor,
      this.language,
      this.dateFormat,
      this.listLanguage = const []});
}

class DockStyle {
  final Color? backgroundColor;
  final Color? tooltipBackgroundColor;
  final TextStyle? tooltipTextStyle;

  DockStyle(
      {this.backgroundColor,
      this.tooltipBackgroundColor,
      this.tooltipTextStyle});
}

enum AppIconPosition { dock, desktop }

class WindowsModel {
  int index;
  final String iconUrl;
  final String name;
  AppIconPosition iconPosition;
  Size size;
  WindowsModelStyle? style;
  bool canExpand;
  bool canMinimized;
  bool isMinimized;
  Widget child;
  bool isFullScreen;
  bool isCurrentScreen = true;
  List<Widget> states = [];
  bool isOpenWindow = false;
  WindowsModel(
      {required this.index,
      required this.size,
      required this.name,
      required this.iconUrl,
      this.iconPosition = AppIconPosition.desktop,
      this.style,
      // required this.position,
      // this.breakPointW,
      this.canExpand = true,
      this.canMinimized = true,
      // this.visible = true,
      this.isFullScreen = false,
      this.isMinimized = false,
      // this.isCurrentScreen = true,
      // required this.screenName,
      required this.child});

  // WindowsModel copyWith({
  //   int? index,
  //   Size? size,
  //   Color? color,
  //   Offset? position,
  //   double? breakPointW,
  //   bool? canExpand,
  //   bool? canMinimized,
  //   Widget? child,
  //   String? screenName,
  //   bool? visible,
  //   bool? isMinimized,
  //   bool? isFullScreen,
  //   bool? withShadow,
  //   String? iconUrl,
  //   WindowsModelStyle? style,
  //   bool? isCurrentScreen,
  // }) {
  //   return WindowsModel(
  //     index: index ?? this.index,
  //     size: size ?? this.size,
  //     style: style ?? this.style,
  //     iconUrl: iconUrl ?? this.iconUrl,
  //     isCurrentScreen: isCurrentScreen ?? this.isCurrentScreen,
  //     states: states,
  //     // color: color ?? this.color,
  //     // position: position ?? this.position,
  //     // breakPointW: breakPointW ?? this.breakPointW,
  //     canExpand: canExpand ?? this.canExpand,
  //     canMinimized: canMinimized ?? this.canMinimized,
  //     child: child ?? this.child,
  //     // screenName: screenName ?? this.screenName,
  //     // visible: visible ?? this.visible,
  //     isFullScreen: isFullScreen ?? this.isFullScreen,
  //     isMinimized: isMinimized ?? this.isMinimized,
  //   );
  // }
}
