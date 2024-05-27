// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:os_ui/src/os/macOs/windows_management/model/model.dart';

/// The controller class for managing windows in a macOS-like interface.
class WindowsManagementController {
  final _windows = ValueNotifier<List<WindowsModel>>([]);

  final List<WindowsModel> applications;
  WindowsManagementController(
      {required this.applications,
      required this.launchIconPath,
      required this.appleIconPath,
      this.dockStyle,
      this.topBarModel}) {
    /// Add the launcher to the list of windows.
    _windows.value.add(_launcher(launchIconPath));

    /// Add the applications to the list of windows.
    _windows.value.addAll(applications);
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
      throw Exception("Window not found");
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
  void addWindow(WindowsModel window) {
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

  /// Transition to a new screen within the current window.
  void toGo({required Widget child, WindowsModel? window}) {
    if (window != null) {
      _currentWindow =
          windows.value.indexWhere((element) => element.index == window.index);
    }
    checkIfWindowExist();

    _windows.value[_currentWindow].isCurrentScreen = true;
    _windows.value[_currentWindow].states
        .add(_windows.value[_currentWindow].child!);
    _windows.value[_currentWindow].child = child;
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
    _windows.value[_currentWindow].child =
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
}

WindowsModel _launcher(String iconUrl) => WindowsModel(
    size: Size.zero,
    name: "Launcher",
    iconUrl: iconUrl,
    iconPosition: AppIconPosition.dock,
    child: const SizedBox.shrink())
  ..index = 0
  ..isLaunchpad = true;
