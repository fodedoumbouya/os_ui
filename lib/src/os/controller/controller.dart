// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:os_ui/src/os/macOs/model/toast.dart';
import 'package:os_ui/src/os/macOs/windows_management/model/model.dart';

/// The controller class for managing windows in a macOS-like interface.
/// and tost
/// example:
/// check the github repository for the full example
/// url: https://github.com/fodedoumbouya/os_ui.git
/// ```dart
///  WindowsManagementController windowsManagementController =
///       WindowsManagementController(

///           /// path to the launcher icon
///           launchIconPath: "images/launcher.png",

///           //// path to the apple icon
///           appleIconPath: "images/applelogo.png",

///           //// show the flutter text
///           showFlutterText: true,

///           //// list of applications to be displayed on the macOs
///           applications: [
///             WindowsModel(
///               //// name of the application
///               name: "Toast",

///               //// size of the application window if you decide to just show the icon and not display the window on tap on the icon
///               //// set the size to Size.zero
///               //// if you want to display the window on tap on the icon, set the size to the size of the window
///               //// and user can minimize, maximize, and expand the window
///               //// if you don't want the user to minimize, maximize, and expand the window, set [canMinimized],[canExpand] to false
///               size: Size.zero,

///               //// position of the icon on the os
///               //// [AppIconPosition.desktop] to display the icon on the desktop
///               //// [AppIconPosition.dock] to display the icon on the dock
///               //// [AppIconPosition.both] to display the icon on the desktop and dock
///               iconPosition: AppIconPosition.desktop,

///               //// url of the icon
///               //// you can use a network image or local image
///               iconUrl: "images/alert.png",

///               //// style of the application window
///               style: WindowsModelStyle(
///                 barColor: Colors.blue,
///               ),

///               //// [onTap] function to be called on tap on the icon and the window is not displayed
///               //// if you want to display the window on tap on the icon, set the [entryApp] function
///               onTap: (controller) {
///                 //// on tap on the  app icon
///                 //// show a toast
///                 controller.showToast(
///                   content: const Text("Toast Content"),
///                   title: const Text("Toast Title"),
///                   leading: const Icon(Icons.ac_unit),
///                 );
///               },
///             ),
///             WindowsModel(
///               name: "Dart",
///               size: const Size(700, 700),
///               iconPosition: AppIconPosition.desktop,
///               iconUrl: "images/dart.png",
///               style: WindowsModelStyle(
///                 barColor: Colors.blue,
///               ),

///               //// [entryApp] function to be called on tap on the icon and the window is displayed
///               entryApp: (controller) {
///                 return Screen1(controller: controller);
///               },
///             ),
///             WindowsModel(
///               name: "Flutter",
///               size: const Size(700, 700),
///               iconPosition: AppIconPosition.both,
///               canMinimized: false,
///               canExpand: false,
///               iconUrl: "images/flutter.png",
///               style: WindowsModelStyle(
///                 barColor: Colors.blue,
///               ),
///               entryApp: (controller) => Container(
///                 color: Colors.red,
///                 alignment: Alignment.center,
///                 child: const Text("Flutter",
///                     style: TextStyle(color: Colors.white)),
///               ),
///             ),
///           ],

///           //// top bar model for the macOs
///           topBarModel: TopBarModel(
///             /// barText: "MacOs",
///             /// popupMenuItemColor: Colors.white,

///             //// popup menu items on the list language
///             listLanguages: [
///               TopBarPopupMenuItem(
///                 text: "EN",
///                 onTap: () {
///                   print("EN");
///                 },
///               ),
///               TopBarPopupMenuItem(
///                 text: "FR",
///                 onTap: () {
///                   print("FR");
///                 },
///               )
///             ],

///             //// popup menu items on the apple icon
///             popupMenuItemsOnAppleIcon: [
///               TopBarPopupMenuItem(
///                 text: "About",
///               ),
///               TopBarPopupMenuItem(
///                 text: "Quit",
///               )
///             ],
///           ));

/// ```
///
class WindowsManagementController {
  final _windows = ValueNotifier<List<WindowsModel>>([]);

  final List<WindowsModel> applications;
  WindowsManagementController({
    required this.applications,
    required this.launchIconPath,
    required this.appleIconPath,
    this.dockStyle,
    this.topBarModel,
    this.showFlutterText = true,
  }) {
    /// Add the launcher to the list of windows.
    _windows.value.add(_launcher(launchIconPath));

    /// add application from top bar
    if (topBarModel != null) {
      for (var item in topBarModel!.popupMenuItemsOnAppleIcon) {
        if (item.entryApp != null) {
          _windows.value.add(item.entryApp!);
        }
      }
    }

    /// Add the applications to the list of windows.
    _windows.value.addAll(applications);

    /// check if the application is open window or not
    /// if open window then set the current window to the index of the application
    for (var i = 0; i < _windows.value.length; i++) {
      final element = _windows.value[i];
      if (element.isOpenWindow) {
        _currentWindow = i;
        break;
      }
    }
  }

  /// The path to the icon for the launcher.
  String launchIconPath;

  /// The path to the icon for the Apple icon.
  String appleIconPath;

  /// The style for the dock.
  DockStyle? dockStyle;

  /// The model for the top bar.
  TopBarModel? topBarModel;

  /// The style for the desktop icons.
  DesktopStyle? desktopStyle;

  MacOsToast toast = MacOsToast();

  /// The flag for showing the Flutter text.
  bool showFlutterText;

  /// The index of the current window.
  int _currentWindow = 0;

  /// The notifier for the launchpad toggle.
  final _showLaunchPad = ValueNotifier<bool>(false);

  void showLaunchPadToggle() {
    _showLaunchPad.value = !_showLaunchPad.value;
    launchPadToggle.notifyListeners();
  }

  ValueNotifier<bool> get launchPadToggle => _showLaunchPad;

  /// Get the value notifier for the list of windows.
  ValueNotifier<List<WindowsModel>> get windows => _windows;

  /// Check if the current window exists. Throws an exception if it doesn't.
  checkIfWindowExist() {
    if (_currentWindow == -1) {
      throw Exception(
          "Application not found. make sure the application exist in applications list or use [addApp] method to add the application");
    }
  }

  /// Swap to the window with the specified index.
  void swapToCurrentWindow({int? index}) {
    if (index != null) {
      _currentWindow =
          windows.value.indexWhere((element) => element.index == index);
    }
    checkIfWindowExist();
    _windows.value[_currentWindow].isCurrentScreen = true;
    sortWindows();
  }

  /// Add a new window to the list of windows.
  void openWindow(WindowsModel window) {
    _currentWindow =
        windows.value.indexWhere((element) => element.index == window.index);
    checkIfWindowExist();
    _windows.value[_currentWindow].isOpenWindow = true;

    sortWindows();
  }

  /// Sort the windows based on the current window.
  Future sortWindows() async {
    final currentWindowWidget = _windows.value[_currentWindow];
    _windows.value.removeAt(_currentWindow);
    _windows.value.add(currentWindowWidget);
    windows.notifyListeners();
    return;
  }

  /// update the position of the window.
  void updatePosition(
      {required WindowsModel window, required WindowPosition position}) {
    _currentWindow =
        windows.value.indexWhere((element) => element.index == window.index);
    checkIfWindowExist();
    if (!_windows.value[_currentWindow].isFullScreen) {
      _windows.value[_currentWindow].lastPosition = position;
    }
  }

  /// Transition to a new screen within the current window.
  void goTo(
      {required Widget Function(WindowsManagementController controller)
          entryApp,
      WindowsModel? window}) {
    if (window != null) {
      _currentWindow =
          windows.value.indexWhere((element) => element.index == window.index);
    }
    checkIfWindowExist();

    _windows.value[_currentWindow].isCurrentScreen = true;
    _windows.value[_currentWindow].states
        .add(_windows.value[_currentWindow].entryApp!);
    _windows.value[_currentWindow].entryApp = entryApp;
    windows.notifyListeners();
  }

  /// Go back to the previous screen within the current window.
  void goBack({WindowsModel? window}) {
    if (window != null) {
      _currentWindow =
          windows.value.indexWhere((element) => element.index == window.index);
    }
    checkIfWindowExist();
    if (_windows.value[_currentWindow].states.isEmpty) {
      close(index: _currentWindow);
      return;
    }
    _windows.value[_currentWindow].isCurrentScreen = true;
    _windows.value[_currentWindow].entryApp =
        _windows.value[_currentWindow].states.last;
    _windows.value[_currentWindow].states.removeLast();
    windows.notifyListeners();
  }

  /// Close all windows.
  void closeAllWindow() {
    for (var element in windows.value) {
      element.isOpenWindow = false;
    }
    _currentWindow = -1;
    windows.notifyListeners();
  }

  /// Minimize the window with the specified index.
  void minimize({int? index}) {
    if (index != null) {
      _currentWindow =
          windows.value.indexWhere((element) => element.index == index);
    }
    checkIfWindowExist();
    final w = _windows.value[_currentWindow];
    w.isMinimized = true;
    _windows.value.removeAt(_currentWindow);
    _windows.value.add(w);
    windows.notifyListeners();
  }

  /// Maximize the window with the specified index.
  void maximize({int? index}) {
    if (index != null) {
      _currentWindow =
          windows.value.indexWhere((element) => element.index == index);
    }
    checkIfWindowExist();
    final w = _windows.value[_currentWindow];
    w.isMinimized = false;
    _windows.value.removeAt(_currentWindow);
    _windows.value.add(w);
    windows.notifyListeners();
  }

  /// Set the window with the specified index to full screen mode.
  void fullScreen({int? index}) async {
    swapToCurrentWindow(index: index);
    if (index != null) {
      _currentWindow =
          windows.value.indexWhere((element) => element.index == index);
    }
    checkIfWindowExist();
    _windows.value[_currentWindow].isFullScreen = true;
  }

  /// Set the window with the specified index to normal screen mode.
  void unFullScreen({int? index}) {
    if (index != null) {
      _currentWindow =
          windows.value.indexWhere((element) => element.index == index);
    }
    checkIfWindowExist();
    sortWindows();

    _windows.value[_currentWindow].isFullScreen = false;
  }

  /// Close the window with the specified index.
  void close({required int index}) {
    _currentWindow =
        _windows.value.indexWhere((element) => element.index == index);

    /// set the window to be closed and initialize the window
    _windows.value[_currentWindow].isOpenWindow = false;
    _windows.value[_currentWindow].isMinimized = false;
    _windows.value[_currentWindow].isFullScreen = false;
    _windows.value[_currentWindow].isCurrentScreen = false;
    _windows.value[_currentWindow].states = [];
    windows.notifyListeners();
  }

  /// [showToast] is a function that shows a toast.
  void showToast({
    Widget? content,
    Widget? title,
    Widget? leading,
    Widget? trailing,
    Duration? duration,
    Decoration? toastDecoration,
    EdgeInsetsGeometry? contentPadding,
    bool autoDismiss = true,
  }) async {
    if (toast.showToast.value) {
      hideToast();
      await Future.delayed(const Duration(milliseconds: 500));
    }
    toast
      ..content = content
      ..title = title
      ..leading = leading
      ..trailing = trailing
      ..duration = duration
      ..toastDecoration = toastDecoration
      ..autoDismiss = autoDismiss
      ..contentPadding = contentPadding
      ..showToast.value = true;
    toast.showToast.notifyListeners();
    if (autoDismiss) {
      Future.delayed(
          (duration ?? const Duration(seconds: 2)) +
              const Duration(milliseconds: 300), () {
        if (toast.showToast.value == false) return;
        toast.showToast.value = false;
        toast.showToast.notifyListeners();
      });
    }
  }

  /// [hideToast] is a function that hides the toast.
  void hideToast() {
    if (toast.showToast.value) {
      toast.showToast.value = false;
      toast.showToast.notifyListeners();
    }
  }
}

WindowsModel _launcher(String iconUrl) => WindowsModel(
      size: Size.zero,
      name: "Launcher",
      iconUrl: iconUrl,
      iconPosition: AppIconPosition.dock,
      entryApp: (controller) => const SizedBox.shrink(),
    )
      ..index = 0
      ..isLaunchpad = true;
