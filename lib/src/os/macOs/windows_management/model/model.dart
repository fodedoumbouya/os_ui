import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Define the style for the WindowsModel
class WindowsModelStyle {
  final Color? barColor; // The color of the top bar
  final Color? shadowColor; // The color of the shadow

  WindowsModelStyle({this.barColor, this.shadowColor});
}

// Define the model for the top bar
class TopBarModel {
  final Color? backgroundColor; // The background color of the top bar
  final TextStyle? textStyle; // The text style of the top bar
  final Color? iconColor; // The color of the icons in the top bar
  final String? barText; // The text displayed in the top bar
  final Function? onAbout; // The callback function for the "About" action
  final List<PopupMenuItem>
      popupMenuItemsOnAppleIcon; // The popup menu items displayed when clicking on the Apple icon
  final Color? popupMenuItemColor; // The color of the popup menu items
  final Color?
      popupMenuItemShadowColor; // The color of the shadow of the popup menu items
  final Color?
      popupMenuItemSurfaceTintColor; // The color of the surface of the popup menu items
  final ValueNotifier<String?>?
      language; // The notifier for the selected language
  final List<PopupMenuItem> listLanguage; // The list of available languages
  final DateFormat? dateFormat; // The date format for the top bar

  TopBarModel({
    this.backgroundColor,
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
    this.listLanguage = const [],
  });
}

// Define the style for the dock
class DockStyle {
  final Color? backgroundColor; // The background color of the dock
  final Color?
      tooltipBackgroundColor; // The background color of the tooltips in the dock
  final TextStyle?
      tooltipTextStyle; // The text style of the tooltips in the dock

  DockStyle({
    this.backgroundColor,
    this.tooltipBackgroundColor,
    this.tooltipTextStyle,
  });
}

// Define the position of the app icon
enum AppIconPosition {
  dock, // The app icon is in the dock
  desktop, // The app icon is on the desktop
}

// Define the model for the windows
class WindowsModel {
  static int _currentIndex =
      0; // Add a static variable to keep track of the current index
  int index = -1; // The index of the window
  final String iconUrl; // The URL of the window icon
  final String name; // The name of the window
  AppIconPosition iconPosition; // The position of the app icon
  Size size; // The size of the window
  WindowsModelStyle? style; // The style of the window
  bool canExpand; // Whether the window can be expanded
  bool canMinimized; // Whether the window can be minimized
  bool isMinimized = false; // Whether the window is minimized
  Widget child; // The child widget of the window
  bool isFullScreen = false; // Whether the window is in full screen mode
  bool isCurrentScreen = true; // Whether the window is the current screen
  List<Widget> states = []; // The list of states of the window
  bool isOpenWindow = false; // Whether the window is open

  WindowsModel({
    required this.size,
    required this.name,
    required this.iconUrl,
    this.iconPosition = AppIconPosition.desktop,
    this.style,
    this.canExpand = true,
    this.canMinimized = true,
    required this.child,
  }) {
    if (index == -1) {
      // If the index is not provided, auto increment it
      index = _currentIndex++;
    }
  }
}
