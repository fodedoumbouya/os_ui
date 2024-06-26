import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:os_ui/os_ui.dart';

// Define the style for the WindowsModel
class WindowsModelStyle {
  final Color? barColor; // The color of the top bar
  final Color? shadowColor; // The color of the shadow

  WindowsModelStyle({this.barColor, this.shadowColor});
}

class TopBarPopupMenuItem {
  String text;
  TextStyle? textStyle;
  final WindowsModel? entryApp;
  void Function()? onTap;
  final EdgeInsets? padding;
  TopBarPopupMenuItem({
    required this.text,
    this.textStyle,
    this.entryApp,
    this.onTap,
    this.padding,
  }) : assert(entryApp == null || onTap == null,
            'entryApp and onTap cannot be use together');

  TopBarPopupMenuItem copyWith({
    String? text,
    TextStyle? textStyle,
    WindowsModel? entryApp,
    EdgeInsets? padding,
    void Function()? onTap,
  }) {
    return TopBarPopupMenuItem(
      text: text ?? this.text,
      textStyle: textStyle ?? this.textStyle,
      entryApp: entryApp ?? this.entryApp,
      padding: padding ?? this.padding,
      onTap: onTap ?? this.onTap,
    );
  }
}

// Define the model for the top bar
class TopBarModel {
  final Color? backgroundColor; // The background color of the top bar
  final TextStyle? textStyle; // The text style of the top bar
  final Color? iconColor; // The color of the icons in the top bar
  final String? barText; // The text displayed in the top bar
  List<TopBarPopupMenuItem>
      popupMenuItemsOnAppleIcon; // The popup menu items displayed when clicking on the Apple icon
  final Color? popupMenuItemColor; // The color of the popup menu items
  final Color?
      popupMenuItemShadowColor; // The color of the shadow of the popup menu items
  final Color?
      popupMenuItemSurfaceTintColor; // The color of the surface of the popup menu items
  final List<TopBarPopupMenuItem>
      listLanguages; // The list of available languages
  final DateFormat? dateFormat; // The date format for the top bar

  TopBarModel({
    this.backgroundColor,
    this.textStyle,
    this.iconColor,
    this.barText,
    this.popupMenuItemsOnAppleIcon = const [],
    this.popupMenuItemColor,
    this.popupMenuItemShadowColor,
    this.popupMenuItemSurfaceTintColor,
    this.dateFormat,
    this.listLanguages = const [],
  });
}

/// The style for the desktop icons
class DesktopStyle {
  /// The text style of the desktop icons
  final TextStyle? textStyle;
  DesktopStyle({this.textStyle});
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
  both, // The app icon is in both the dock and on the desktop
  none, // The app icon is not displayed
}

/// [EntryWidgetBuilder] is a function that returns a widget.
typedef EntryWidgetBuilder = Widget Function(
  WindowsManagementController controller,
);

typedef EntryTapBuilder = void Function(
  WindowsManagementController controller,
);

class WindowPosition {
  double? newTop;
  double? newLeft;
  double? newRight;
  double? newBottom;

  WindowPosition({
    this.newTop,
    this.newLeft,
    this.newRight,
    this.newBottom,
  });

  WindowPosition copyWith({
    double? newTop,
    double? newLeft,
    double? newRight,
    double? newBottom,
  }) {
    return WindowPosition(
      newTop: newTop ?? this.newTop,
      newLeft: newLeft ?? this.newLeft,
      newRight: newRight ?? this.newRight,
      newBottom: newBottom ?? this.newBottom,
    );
  }

  @override
  String toString() {
    return 'WindowPosition(newTop: $newTop, newLeft: $newLeft, newRight: $newRight, newBottom: $newBottom)';
  }
}

// Define the model for the windows
class WindowsModel {
  static int _currentIndex =
      1; // Add a static variable to keep track of the current index
  /// The index of the window
  int index = -1;

  /// The URL of the window icon and support [network] and [asset]
  final String iconUrl;

  /// The name of the window
  final String name;

  /// The position of the app icon
  AppIconPosition iconPosition;

  /// The size of the window
  Size size;

  /// The style of the window
  WindowsModelStyle? style;

  /// Whether the window can be expanded
  bool canExpand;

  /// Whether the window can be minimized
  bool canMinimized;

  /// Whether the window is minimized
  bool isMinimized = false;

  /// The child widget of the window
  EntryWidgetBuilder? entryApp;

  /// The callback function for the "Open" action
  EntryTapBuilder? onTap;

  /// Whether the window is in full screen mode
  bool isFullScreen = false;

  /// Whether the window is the current screen
  bool isCurrentScreen = true;

  /// The list of states of the window
  List<EntryWidgetBuilder> states = [];

  /// Whether the window is open
  bool isOpenWindow = false;

  /// Whether the window is a launchpad
  bool isLaunchpad = false;

  bool enableDragWidgets;

  WindowPosition? lastPosition;

  WindowsModel(
      {required this.size,
      required this.name,
      required this.iconUrl,
      this.iconPosition = AppIconPosition.none,
      this.style,
      this.canExpand = true,
      this.canMinimized = true,
      this.entryApp,
      this.onTap,
      this.enableDragWidgets = true}) {
    assert(!(entryApp != null && onTap != null),
        'entryApp or onTap must be not nul');
    if (index == -1) {
      // If the index is not provided, auto increment it
      index = _currentIndex++;
    }
  }

  //copyWith
  WindowsModel copyWith({
    String? iconUrl,
    String? name,
    AppIconPosition? iconPosition,
    Size? size,
    WindowsModelStyle? style,
    bool? canExpand,
    bool? canMinimized,
    EntryWidgetBuilder? entryApp,
    void Function(WindowsManagementController)? onTap,
    bool? enableDragWidgets,
  }) {
    return WindowsModel(
      size: size ?? this.size,
      name: name ?? this.name,
      iconUrl: iconUrl ?? this.iconUrl,
      iconPosition: iconPosition ?? this.iconPosition,
      style: style ?? this.style,
      canExpand: canExpand ?? this.canExpand,
      canMinimized: canMinimized ?? this.canMinimized,
      entryApp: entryApp ?? this.entryApp,
      onTap: onTap ?? this.onTap,
      enableDragWidgets: enableDragWidgets ?? this.enableDragWidgets,
    )
      ..index = index
      ..isMinimized = isMinimized
      ..isFullScreen = isFullScreen
      ..isCurrentScreen = isCurrentScreen
      ..states = states
      ..isOpenWindow = isOpenWindow
      ..isLaunchpad = isLaunchpad
      ..lastPosition = lastPosition;
  }
}
